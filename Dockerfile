FROM golang:1.14-alpine as builder
RUN apk add --no-cache upx
WORKDIR /go_server
COPY . .
RUN GOOS=linux go build -ldflags "-s -w" -o desafio_docker -i ./src/server/main.go
RUN upx --brute desafio_docker

FROM busybox:latest
WORKDIR /go_server
COPY --from=builder /go_server/desafio_docker .
RUN ls -lah

ENTRYPOINT ["./desafio_docker"]