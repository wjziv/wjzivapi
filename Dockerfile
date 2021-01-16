FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8
#-alpine3.10
#RUN apk add --no-cache libressl-dev musl-dev libffi-dev gcc

# set path to our python api file
ENV MODULE_NAME="app.main"

COPY ./ /app

RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install

ADD ./certs/pgsql.crt /usr/local/share/ca-certificates/DO-PG-CA.crt
RUN chmod 644 /usr/local/share/ca-certificates/DO-PG-CA.crt && update-ca-certificates

#RUN apk --no-cache add ca-certificates

#RUN apk add openssl
RUN openssl req -nodes -newkey rsa:2048 -keyout /usr/local/share/ca-certificates/DO-PG-KY.key -out example.csr -subj "{$OPENSSL_INPUT}"
