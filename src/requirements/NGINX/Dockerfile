FROM alpine:3.19

RUN apk add --no-cache nginx

EXPOSE 443 9000

ENTRYPOINT [ "nginx" ]

CMD  [ "-g", "daemon off;" ]