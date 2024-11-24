FROM alpine:3.19

COPY tools/default.conf tools/setup.sh /etc/nginx/http.d/

RUN apk add --no-cache nginx openssl tini && \
	chmod +x /etc/nginx/http.d/setup.sh

EXPOSE 443 9000

ENTRYPOINT [ "/sbin/tini", "--", "/etc/nginx/http.d/setup.sh" ]

CMD [ ]