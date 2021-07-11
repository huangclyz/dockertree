
FROM registry.example.com/base-os/debian:buster-10.9
LABEL "maintainer"=<huangclyz@example.com>
RUN addgroup --gid 1001 axadm \
    && adduser  --ingroup axadm  --disabled-password --home /axadm --gecos "axadm" --shell /bin/bash --uid 1001 axadm \
    && cd /axadm/ && mkdir appsystems applogs appdata middleware monitor
        # appsystems:应用包目录
        # applogs日志目录
        # appdata应用持久化数据目录
        # middlware中间件软件目录
        # monitor监控agent目录
RUN apt-get update \
    && apt-get install -y gcc libpcre3 libpcre3-dev zlib1g-dev openssl libssl-dev libgd-dev libgeoip-dev make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN wget http://nginx.org/download/nginx-1.19.10.tar.gz \
    && tar -xf nginx-1.19.10.tar.gz \
        && cd nginx-1.19.10 \
        && ./configure \
                --prefix=/axadm/middleware/nginx \
                --sbin-path=/axadm/middleware/nginx/sbin/nginx \
                --modules-path=/axadm/middleware/nginx/modules \
                --error-log-path=/axadm/applogs/error.log \
                --http-log-path=/axadm/applogs/access.log \
                --conf-path=/axadm/middleware/nginx/nginx.conf \
                --pid-path=/axadm/middleware/nginx/tmp/nginx.pid \
                --lock-path=/axadm/middleware/nginx/tmp/nginx.lock \
                --http-client-body-temp-path=/axadm/middleware/nginx/tmp/client_temp \
                --http-proxy-temp-path=/axadm/middleware/nginx/tmp/proxy_temp \
                --http-fastcgi-temp-path=/axadm/middleware/nginx/tmp/fastcgi_temp \
                --http-uwsgi-temp-path=/axadm/middleware/nginx/tmp/uwsgi_temp \
                --http-scgi-temp-path=/axadm/middleware/nginx/tmp/scgi_temp \
                --user=nginx \
                --group=nginx \
                --with-mail \
                --with-stream \
                --with-compat \
                --with-threads \
                --with-file-aio \
                --with-poll_module \
                --with-select_module \
                --with-http_v2_module \
                --with-http_flv_module \
                --with-http_mp4_module \
                --with-http_sub_module \
                --with-http_dav_module \
                --with-http_ssl_module \
                --with-http_geoip_module \
                --with-http_slice_module \
                --with-http_gunzip_module \
                --with-http_realip_module \
                --with-http_addition_module \
                --with-http_auth_request_module \
                --with-http_image_filter_module \
                --with-http_gzip_static_module \
                --with-http_random_index_module \
                --with-http_secure_link_module \
                --with-http_degradation_module \
                --with-http_stub_status_module \
                --with-mail_ssl_module \
                --with-stream_ssl_module \
                --with-stream_realip_module \
                --with-stream_ssl_preread_module \
                --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fPIC' \
                --with-ld-opt='-Wl,-z,relro -Wl,-z,now -pie' \
    && make && make install \
    && cd ../ && rm -rf nginx* \
    && cd /axadm/middleware/nginx/ && mkdir conf.d modules \
    && chown -R axadm:axadm /axadm
USER axadm
COPY nginx.conf /axadm/middleware/nginx/
CMD ["/axadm/middleware/nginx/sbin/nginx", "-g", "daemon off;"]
