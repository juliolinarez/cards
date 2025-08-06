.PHONY: up down build bash attach logs build-css install up-test down-test up-prod down-prod

# Development environment (default)
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

# Test environment
up-test:
	docker compose -f docker-compose.test.yml up

down-test:
	docker compose -f docker-compose.test.yml down

bash-test:
	docker compose -f docker-compose.test.yml run --rm app_test bash

# Production environment
up-prod:
	docker compose -f docker-compose.production.yml up

down-prod:
	docker compose -f docker-compose.production.yml down

bash-prod:
	docker compose -f docker-compose.production.yml run --rm app_prod bash

# Build CSS with DaisyUI
build-css:
	docker compose run --rm app npm run build:css

# Install/update dependencies (Ruby and Node.js)
install:
	docker compose run --rm app bash -c "bundle install && npm install"

# Database commands
db-create:
	docker compose run --rm app bash -c "bundle exec rails db:create"

db-migrate:
	docker compose run --rm app bash -c "bundle exec rails db:migrate"

db-reset:
	docker compose run --rm app bash -c "bundle exec rails db:drop db:create db:migrate"
