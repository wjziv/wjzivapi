FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-slim
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN apt install -y libpq-dev postgresql-server-dev-all

ENV MODULE_NAME="app.main"

COPY ./ /app

RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install

ADD ./certs/postgresql.crt /usr/local/share/ca-certificates/postgresql.crt
RUN chmod 600 /usr/local/share/ca-certificates/postgresql.crt && update-ca-certificates