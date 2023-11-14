FROM crystallang/crystal:1-alpine

RUN apk add --no-cache \
      bash \
      curl \
      gawk \
      jq \
      tini

RUN addgroup -S app && adduser -S app -G app -h /app

WORKDIR /app

COPY . /app

RUN shards build -v --production && \
    chown -R app:app /app

USER app

ENTRYPOINT ["/sbin/tini", "--", "/app/bin/projectdbctl"]
