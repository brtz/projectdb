FROM crystallang/crystal:1-alpine

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
RUN chmod +x /sbin/tini

RUN addgroup -S app && adduser -S app -G app -h /app

WORKDIR /app

COPY . /app

RUN shards build -v --production

USER app

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/app/"]
