# setup py app
FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8

# set path to our python api file
ENV MODULE_NAME="app.main"

# copy contents of project into docker
COPY ./ /app

# install poetry
RUN pip install poetry

# disable virtualenv for peotry
RUN poetry config virtualenvs.create false

# install dependencies
RUN poetry install

# copy in ca cert
COPY ./certs/pgsql.crt ~/.postgresql/pgsql.crt
RUN chmod 777 ~/.postgresql/pgsql.crt