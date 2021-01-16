FROM python:3.8-slim

COPY ./ ./app

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

COPY ./ssl/* /usr/local/share/ca-certificates/

RUN update-ca-certificates

RUN pip install -r requirements.txt

EXPOSE 8080

CMD [ "uvicorn", "main:app", "--host", "0.0.0.0"]