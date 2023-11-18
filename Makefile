build:
	docker-compose -f srcs/docker-compose.yml build
up:
	docker-compose -f srcs/docker-compose.yml up
down:
	docker-compose -f srcs/docker-compose.yml down -v
remove:
	sudo rm -rf /home/ael-beka/data/wordpress/* /home/ael-beka/data/mariadb/*

cache:
	docker system prune -af
