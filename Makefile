.PHONY: up down build bash attach logs build-css install

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

# Build CSS with DaisyUI
build-css:
	docker compose run --rm app npm run build:css

# Install/update dependencies (Ruby and Node.js)
install:
	docker compose run --rm app bash -c "bundle install && npm install"
