.PHONY: up down build bash attach logs build-css install dev

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

# Start Vite dev server for HMR
dev:
	docker compose run --rm -p 3036:3036 app npm run dev -- --host 0.0.0.0

# Build CSS with Vite and Tailwind
build-css:
	docker compose run --rm app npm run build

# Build CSS in watch mode for development
build-css-watch:
	docker compose run --rm app npm run dev

# Install/update dependencies (Ruby and Node.js)
install:
	docker compose run --rm app bash -c "bundle install && npm install"
