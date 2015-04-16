FROM alpine:3.1

ENV OPENRESTY_VERSION 1.7.10.1
ENV PATH /usr/local/openresty/nginx/sbin:$PATH

RUN apk --update add pcre libgcc geoip && \
    apk --update add \
    --virtual build-deps \
    build-base \
    readline-dev \
    ncurses-dev \
    pcre-dev \
    zlib-dev \
    openssl-dev \
    perl \
    wget \
    make \
    tar \
    geoip-dev && \
    rm -rf /var/cache/apk/* && \
    mkdir /build_tmp && cd /build_tmp && \
    wget http://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz && \
    tar xf ngx_openresty-${OPENRESTY_VERSION}.tar.gz && \
    cd ngx_openresty-${OPENRESTY_VERSION} && ./configure \
    --with-pcre-jit \
    --with-ipv6 \
    --with-http_geoip_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    && make && make install && \
    apk del build-deps && rm -rf /build_tmp

VOLUME /nginx

WORKDIR /nginx

CMD ["nginx", "-p", "/nginx/", "-c", "conf/nginx.conf"]
