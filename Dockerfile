# Build application
FROM golang:1.17rc2 AS builder

COPY . /go/src/github.com/BeryJu/acme-for-appliances

RUN cd /go/src/github.com/BeryJu/acme-for-appliances && \
    go build -v -o /go/bin/acme-for-appliances

# Final container
FROM debian

COPY acme-for-appliances /

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    apt-get clean

RUN update-ca-certificates

VOLUME [ "/storage" ]

ENTRYPOINT [ "/acme-for-appliances" ]
