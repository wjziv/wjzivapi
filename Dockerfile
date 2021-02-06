FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-slim-buster
# RUN apk add --no-cache libressl-dev musl-dev libffi-dev gcc
RUN apt-get update && apt-get install gcc -y

# set path to our python api file
ENV MODULE_NAME="app.main"

COPY ./ /app

RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install

RUN apk --no-cache add ca-certificates
ADD ./certs/postgresql.crt /usr/local/share/ca-certificates/postgresql.crt
RUN chmod 600 /usr/local/share/ca-certificates/postgresql.crt && update-ca-certificates


# RUN apk add openssl
# RUN openssl req -nodes -newkey rsa:2048 -keyout /usr/local/share/ca-certificates/DO-PG-KY.key -out example.csr
#RUN openssl x509 -req -days 365 -in /usr/local/share/ca-certificates/postgresql.crt -signkey /usr/local/share/ca-certificates/postgresql.key -out /usr/local/share/ca-certificates/other_postgresql.crt
# -subj $OPENSSL_INPUT