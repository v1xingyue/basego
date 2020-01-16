FROM golang:1.12-alpine

COPY . /go/src/goapp
WORKDIR /go/src/goapp
RUN go build -o /bin/goapp

FROM alpine:3.10
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --no-cache git && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
RUN go env -w GOPROXY=https://goproxy.cn,direct

COPY --from=0 /bin/goapp /bin/goapp
ENTRYPOINT ["/bin/goapp"]