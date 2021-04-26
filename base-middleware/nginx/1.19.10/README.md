# 构建命令
docker build -t registry.example.com/base-middlware/nginx:1.19.10 .
# 构建引用方式
FROM registry.example.com/base-middlware/nginx:1.19.10
