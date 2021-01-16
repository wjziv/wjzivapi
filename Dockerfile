FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8
#-alpine3.10
#RUN apk add --no-cache libressl-dev musl-dev libffi-dev gcc

# set path to our python api file
ENV MODULE_NAME="app.main"

COPY ./ /app

RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install

#RUN apk --no-cache add ca-certificates