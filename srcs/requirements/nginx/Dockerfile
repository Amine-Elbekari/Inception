FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y nginx openssl

RUN	mkdir /etc/nginx/ssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/setup-ssl.sh /etc/nginx/ssl/

RUN chmod +x /etc/nginx/ssl/setup-ssl.sh

ENTRYPOINT [ "/etc/nginx/ssl/setup-ssl.sh" ]

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]