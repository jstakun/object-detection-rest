import json
from flask import Flask, jsonify, request
from prediction import predict
from prometheus_client import make_wsgi_app

application = Flask(__name__)


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
