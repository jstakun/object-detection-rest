FROM registry.access.redhat.com/ubi8/ubi
MAINTAINER Jaroslaw Stakun jstakun@redhat.com
WORKDIR /app
COPY ./requirements.txt ./*.py /app/
COPY ./models/ /app/models/
RUN yum install -y --nodocs python38; yum clean all && \
    python3 -m pip install -r requirements.txt
EXPOSE 8080
CMD ["gunicorn", "wsgi", "--config", "gunicorn_config.py"]
