FROM registry.example.com/base-os/debian:buster-10.9
LABEL "maintainer"=<huangclyz@example.com>
RUN addgroup --gid 1001 axs \
    && adduser  --ingroup axs  --disabled-password --home /axs --gecos "axs" --shell /bin/bash --uid 1001 axs \
    && mkdir -p /axs/{appsystems,applogs,appdata,middleware,monitor}
        # appsystems:应用包目录
        # applogs日志目录
        # appdata应用持久化数据目录
        # middlware中间件软件目录
        # monitor监控agent目录
ENV JAVA_HOME /axs/middleware/openjdk
ENV JAVA $JAVA_HOME/bin/java
COPY start.sh /axs
RUN wget --progress=dot:giga -O openjdk.tar.gz https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u282-b08/OpenJDK8U-jre_x64_linux_8u282b08.tar.gz \
    && mkdir -p /axs/middleware \
    && tar -xvf openjdk.tar.gz --directory /axs/middleware \
    && rm openjdk.tar.gz \
    && mv /axs/middleware/openjdk-8u282-b08-jre $JAVA_HOME \
    && find $JAVA_HOME/lib -name '*.so' -exec dirname '{}' ';' | sort -u > /etc/ld.so.conf.d/docker-openjdk.conf \
    && ldconfig \
    && chown -R axs:axs /axs && chmod a+x /axs/start.sh

CMD ["/bin/bash","/axs/start.sh"]
