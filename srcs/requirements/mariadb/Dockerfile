FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

RUN chmod +x /var/www/setup-mariadb.sh


CMD  ["bash","/var/www/setup-mariadb.sh"]


