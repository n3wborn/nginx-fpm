USER = $(shell whoami)
UID = $(shell id -u)
GID = $(shell id -g)
PWD = $(shell pwd)
NODE_PKG_MNGR = yarn
NODE = node:lts-slim
COMPOSER = composer:2

.PHONY: docker_build
docker_build:
	docker-compose build

.PHONY: docker_up
docker_up:
	docker-compose up

# use standalone container to avoid root owned vendor directory
.PHONY: composer_install
composer_install:
	docker run --rm -ti -v $(PWD):/app --user $(UID):$(GID) $(COMPOSER) install

# use standalone container to avoid root owned vendor directory
.PHONY: composer_update
composer_update:
	docker run --rm -ti -v $(PWD):/app --user $(UID):$(GID) $(COMPOSER) update

# TODO: add node to docker-compose or keep it as standalone container ?
.PHONY: node_install
node_install:
	docker run --rm --name node_nginx-fpm -u node -w /home/node/app -v $(PWD):/home/node/app $(NODE) $(NODE_PKG_MNGR) install

# TODO: add node to docker-compose or keep it as standalone container ?
.PHONY: node_upgrade
node_upgrade:
	docker run --rm --name node_nginx-fpm -u node -w /home/node/app -v $(PWD):/home/node/app $(NODE) $(NODE_PKG_MNGR) upgrade

.PHONY: node_watch
node_watch:
	# TODO: add node to docker-compose ro keep it as standalone container ?
	docker run --rm --name node_nginx-fpm -u node -w /home/node/app -v $(PWD):/home/node/app $(NODE) $(NODE_PKG_MNGR) watch

.PHONY: database
database:
	docker-compose exec php-fpm composer database

.PHONY: database-dev
database-dev:
	docker-compose exec php-fpm composer database-dev

.PHONY: database-test
database-test:
	docker-compose exec php-fpm composer database-test
