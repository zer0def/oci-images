#FROM golang:1.15-alpine AS builder
FROM golang:1.15 AS builder
ARG VERSION=v0.6.0
WORKDIR /go/src/github.com/iyouport-org
#RUN apk add --no-cache git make perl rsync \
RUN apt update && apt -y install git make perl rsync \
 && git clone https://github.com/iyouport-org/relaybaton -b ${VERSION} \
 && cd relaybaton \
 && make

#FROM alpine:edge
FROM debian:testing-slim
COPY --from=builder /go/src/github.com/iyouport-org/relaybaton/bin/relaybaton /relaybaton
ENTRYPOINT ["/relaybaton"]
