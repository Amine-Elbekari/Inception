FROM debian:bullseye

RUN apt-get update && apt-get -y install php7.4\
        php-fpm \
        php-mysql \
        wget \
        sendmail

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d
COPY ./tools /var/www/html/

RUN chmod +x /var/www/html/setup-wp.sh

ENTRYPOINT [ "/var/www/html/setup-wp.sh" ]

CMD [ "/usr/sbin/php-fpm7.4", "--nodaemonize"]

