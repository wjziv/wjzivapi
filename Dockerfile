FROM python:3.9-alpine

ARG PORT=8080
ENV PORT $PORT

COPY ./ /app
WORKDIR /app
EXPOSE $PORT

RUN apk add --no-cache libressl-dev musl-dev libffi-dev

RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install

CMD uvicorn --host 0.0.0.0 --port $PORT main:app