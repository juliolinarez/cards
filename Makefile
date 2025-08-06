.PHONY: up down build bash attach logs build-css install test test-docs db-create db-migrate db-reset

# Development environment
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

# Install/update dependencies (Ruby and Node.js)
install:
	docker compose run --rm app bash -c "bundle install && npm install"

# Build CSS with DaisyUI
build-css:
	docker compose run --rm app npm run build:css

# Database commands
db-create:
	docker compose run --rm app bash -c "bundle exec rails db:create"

db-migrate:
	docker compose run --rm app bash -c "bundle exec rails db:migrate"

db-reset:
	docker compose run --rm app bash -c "bundle exec rails db:drop db:create db:migrate"

# Test commands
test:
	docker compose exec app bash -c "RAILS_ENV=test bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))"

test-docs:
	docker compose exec app bash -c "RAILS_ENV=test bundle exec rspec --format documentation $(filter-out $@,$(MAKECMDGOALS))"
