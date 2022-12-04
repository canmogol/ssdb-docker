FROM alpine:latest as builder

RUN apk update && \
    apk add gcc python3 && \
    apk add --virtual .build-deps autoconf make g++ git

RUN mkdir -p /usr/src/ssdb

RUN git clone --depth 1 https://github.com/canmogol/ssdb.git /usr/src/ssdb && \
  make -C /usr/src/ssdb && \
  make -C /usr/src/ssdb install && \
  rm -rf /usr/src/ssdb

RUN apk del .build-deps

RUN sed \
    -e 's@ip:.*@ip: 0.0.0.0@' \
    -e 's@cache_size:.*@cache_size: 4096@' \
    -e 's@write_buffer_size:.*@write_buffer_size: 512@' \
    -e 's@level:.*@level: info@' \
    -e 's@output:.*@output:@' \
    -i /usr/local/ssdb/ssdb.conf

FROM alpine:latest
RUN apk --no-cache add ca-certificates python3
EXPOSE 8888
WORKDIR /usr/local/ssdb/
COPY --from=builder /usr/local/ssdb    .
VOLUME /usr/local/ssdb/var/data
VOLUME /usr/local/ssdb/var/meta
CMD ["/usr/local/ssdb/ssdb-server", "/usr/local/ssdb/ssdb.conf"]
