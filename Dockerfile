# 使用官方 Ubuntu 镜像作为基础镜像
FROM ubuntu:latest

# 暴露端口
EXPOSE 80

# 切换为 root 用户
USER root

# 更新软件包信息并安装所需的软件包
RUN apt-get update && \
    apt-get install -y wget tar unzip netcat nginx supervisor qrencode net-tools

# 创建一个工作目录
WORKDIR /app

# 下载并解压多个文件
RUN wget -q https://github.com/2091k/down/raw/main/v2ray/agent.tar.gz && \
    tar -xzvf agent.tar.gz && \
    rm -rf agent.tar.gz

RUN wget -q https://github.com/2091k/down/raw/main/v2ray/gost.tar.gz && \
    tar -xzvf gost.tar.gz && \
    rm -rf gost.tar.gz

RUN wget -q https://github.com/2091k/down/raw/main/v2ray/node.tar.gz && \
    tar -xzvf node.tar.gz && \
    rm -rf node.tar.gz

RUN wget -q https://github.com/2091k/down/raw/main/v2ray/cube.tar.gz && \
    tar -xzvf cube.tar.gz && \
    rm -rf cube.tar.gz

# 复制应用程序文件和脚本到容器中
COPY . .

# 赋予脚本和程序可执行权限
RUN chmod +x start.sh agent gost node cube http_server.sh

# 启动应用程序
CMD ["/app/start.sh"]
