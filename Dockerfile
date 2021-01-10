FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7

# set path to our python api file
ENV MODULE_NAME="wjzivapi.main"

# copy cert
COPY ca-certificate.crt ~/.postgresql/postgresql.crt

# copy contents of project into docker
COPY ./ /app

# install poetry
RUN pip install poetry

# disable virtualenv for peotry
RUN poetry config virtualenvs.create false

# install dependencies
RUN poetry install