# 构建命令
docker build -t registry.example.com/base-os/debian:buster-10.9 .
# 构建引用方式
FROM registry.example.com/base-os/debian:buster-10.9
