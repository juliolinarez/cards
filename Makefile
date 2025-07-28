.PHONY: up down build bash attach logs

up:
	docker compose up

down:
	docker compose down

build:
	docker compose build app

bash:
	docker compose run --rm app bash

attach:
	docker compose attach app

logs:
	docker compose logs -f app