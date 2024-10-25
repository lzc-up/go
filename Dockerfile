FROM golang:1.23.2 AS builder

# 将本地代码复制到容器镜像中。
WORKDIR /app
COPY . .

# 在容器内构建命令。
RUN go mod download && \
    CGO_ENABLED=0 GOOS=linux go build -o go-app hello.go

# 使用一个新的阶段创建一个最小的镜像。
FROM alpine:3.14
COPY --from=builder /app/my-app /usr/local/bin/go-app
# 更新文件权限以确保它是可执行的。
RUN chmod +x /usr/local/bin/go-app
# 设置容器的默认端口
EXPOSE 8081

# 设置容器的默认命令。
CMD ["/usr/local/bin/go-app"]