FROM registry.access.redhat.com/ubi8/ubi
MAINTAINER Jaroslaw Stakun jstakun@redhat.com
ENV PIP_INDEX_URL="https://www.example.com"
WORKDIR /app
COPY ./requirements.txt ./*.py ./blank.jpeg /app/
COPY ./models/ /app/models/
RUN yum install -y --nodocs python38; yum clean all && \
    python3 -m pip install --user -r requirements.txt
EXPOSE 8080
CMD ["gunicorn", "wsgi", "--config", "gunicorn_config.py"]
