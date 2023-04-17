import json
import logging
from flask import Flask, jsonify, request
from prediction import predict
from prometheus_client import make_wsgi_app

application = Flask(__name__)

@application.before_first_request
def setup_logging():
    if not application.debug:
        application.logger.addHandler(logging.StreamHandler())
        application.logger.setLevel(logging.INFO)

@application.route('/')
@application.route('/status')
def status():
    return jsonify({'status': 'ok'})


@application.route('/predictions', methods=['POST'])
def create_prediction():
    data = request.data or '{}'
    body = json.loads(data)
    return jsonify(predict(body))

@application.route('/metrics')
def metrics():
    return make_wsgi_app()  
