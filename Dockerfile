FROM golang:1.12-alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --no-cache git && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
COPY . /go/src/goapp
RUN go env -w GOPROXY=https://goproxy.cn,direct
WORKDIR /go/src/goapp
RUN go build -o /bin/goapp

FROM alpine:3.10
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
RUN apk add --no-cache git 

COPY --from=0 /bin/goapp /bin/goapp
ENTRYPOINT ["/bin/goapp"]