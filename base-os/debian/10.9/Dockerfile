#使用官方debian os镜像
FROM registry.essence.com.cn/base-os/debian:latest
# 镜像作者
LABEL "t_cloud"=<t_cloud@essence.com.cn>
RUN set -eux \
  && echo "deb http://mirrors.aliyun.com/debian/ buster main" > /etc/apt/sources.list \
  && echo "deb http://mirrors.aliyun.com/debian/ buster-updates main" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y procps curl wget net-tools tzdata \
  # 在实际使用中，/etc/localtime需要从宿主机挂载，volumeMount：/etc/localtime ——> /etc/localtime
  && cp /usr/share/zoneinfo/PRC /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
