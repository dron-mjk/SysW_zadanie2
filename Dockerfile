FROM alpine:latest as stage1

WORKDIR /var

RUN apk update && \
    apk upgrade && \
    apk add git python3 py3-pip


COPY app /var/zadanie1/app

WORKDIR /var/zadanie1/app

RUN python -m venv .venv

RUN /var/zadanie1/app/.venv/bin/pip install -r requirements.txt


FROM alpine:latest

COPY --from=stage1 /var/zadanie1 /var/zadanie1

# RUN apk update && \
    # apk upgrade && \
RUN apk add python3 curl

EXPOSE 5000

HEALTHCHECK --start-period=30s --interval=60s CMD curl --fail 127.0.0.1:5000 || exit 1

CMD ["/var/zadanie1/app/.venv/bin/python", "/var/zadanie1/app/main.py"]