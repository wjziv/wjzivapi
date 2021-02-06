FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8
RUN /usr/local/bin/python -m pip install --upgrade pip

ENV MODULE_NAME="app.main"

COPY ./ /app

RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install

ADD ./certs/postgresql.crt /usr/local/share/ca-certificates/postgresql.crt
RUN chmod 600 /usr/local/share/ca-certificates/postgresql.crt && update-ca-certificates