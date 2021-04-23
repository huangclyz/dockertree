# 构建命令
docker build -t registry.example.com/base-middlware/openjdk:1.8.0_282-jre .
# 构建引用方式
FROM registry.example.com/base-middlware/openjdk:1.8.0_282-jre
