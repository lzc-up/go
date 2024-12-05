FROM golang:1.23.2 AS builder

# 将本地代码复制到容器镜像中。
WORKDIR /app
COPY . .

# 在容器内构建命令。
RUN go mod download && \
    CGO_ENABLED=0 GOOS=linux go build -o go-app main.go

# 使用一个新的阶段创建一个最小的镜像。
FROM alpine:3.14

# 创建必要的目录
RUN mkdir -p /app/static /app/templates

# 从构建阶段复制可执行文件和静态资源
COPY --from=builder /app/go-app /usr/local/bin/go-app
COPY --from=builder /app/static/ /app/static/
COPY --from=builder /app/templates/ /app/templates/

# 设置工作目录
WORKDIR /app

# 更新文件权限以确保它是可执行的。
RUN chmod +x /usr/local/bin/go-app

# 设置容器的默认端口
EXPOSE 8081

# 设置容器的默认命令。
CMD ["/usr/local/bin/go-app"]