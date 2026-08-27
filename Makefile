.PHONY: build up shell stop clean package

COMPOSE = docker compose --project-name ubuntu-shell

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up -d --build

shell: up
	$(COMPOSE) exec ubuntu bash

stop:
	$(COMPOSE) down

clean:
	$(COMPOSE) down --volumes --rmi local

package:
	$(MAKE) -C packaging/arch package
