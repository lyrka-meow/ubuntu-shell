.PHONY: build up shell stop clean

build:
	docker compose build

up:
	docker compose up -d --build

shell: up
	docker compose exec ubuntu bash

stop:
	docker compose down

clean:
	docker compose down --volumes
