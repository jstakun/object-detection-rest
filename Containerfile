FROM registry.access.redhat.com/ubi8/ubi
MAINTAINER Jaroslaw Stakun jstakun@redhat.com
ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST
ENV APP_ROOT=/app
ENV PATH=${APP_ROOT}:$PATH
WORKDIR ${APP_ROOT}
COPY ./requirements.txt ./*.py ./blank.jpeg ${APP_ROOT}/
COPY ./models/ ${APP_ROOT}/models/
RUN yum install -y --nodocs python38; yum clean all && \
    python3 -m venv ${APP_ROOT} && \
    ${APP_ROOT}/bin/pip -m pip install --user --no-cache-dir -r requirements.txt && \
    chgrp -R 1001:0 ${APP_ROOT} && chmod -R +x ${APP_ROOT} && ls -al ${APP_ROOT}
USER 1001
EXPOSE 8080
CMD ["gunicorn", "wsgi", "--config", "gunicorn_config.py"]
