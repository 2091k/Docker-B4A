# 使用官方 Ubuntu 镜像作为基础镜像
FROM ubuntu:latest

LABEL build_date="2023-10-02 15:00:10"

# 暴露端口
EXPOSE 80

# 切换为 root 用户
USER root

# 更新软件包信息并安装所需的软件包
RUN apt-get update && \
    apt-get install -y wget dos2unix tar unzip netcat nginx supervisor qrencode net-tools

# 创建一个工作目录
WORKDIR /app

# 下载并解压多个文件
RUN wget -q https://github.com/2091k/down/raw/main/cmbjx/bedrock.tar.gz && \
    tar -xzvf bedrock.tar.gz && \
    rm -rf bedrock.tar.gz

RUN wget -q https://github.com/2091k/down/raw/main/cmbjx/bedrock_ser.tar.gz && \
    tar -xzvf bedrock_ser.tar.gz && \
    rm -rf bedrock_ser.tar.gz


# 复制应用程序文件和脚本到容器中
COPY . .

# 赋予脚本和程序可执行权限
RUN chmod +x start.sh bedrock bedrock_ser http_server.sh

# 启动应用程序
CMD ["/app/start.sh"]
