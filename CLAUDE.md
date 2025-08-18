# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Application Overview

This is a Rails 8.0 application called "Proxyfield" - a modern deck builder for Magic: The Gathering®. The application uses Docker for development and includes a PostgreSQL database with user authentication via Devise.

## Development Commands

### Docker Environment
- `make up` - Start the application with Docker Compose
- `make down` - Stop Docker containers
- `make build` - Build the Docker image
- `make bash` - Open bash shell in container
- `make install` - Install Ruby and Node.js dependencies

### Database Management
- `make db-create` - Create databases
- `make db-migrate` - Run database migrations
- `make db-reset` - Drop, create, and migrate databases

### Testing
- `bundle exec rspec` - Run all tests
- `bundle exec rspec spec/models/user_spec.rb` - Run specific test file
- `bundle exec rspec spec/models/user_spec.rb:10` - Run specific test line
- `bundle exec parallel_rspec spec/` - Run tests in parallel
- `make test` - Run tests via Docker with color output
- `make test-docs` - Run tests with documentation format
- `make test-fast` - Run tests with progress format

### Code Quality
- `bundle exec rubocop` - Run Ruby linter
- `bundle exec rubocop -a` - Auto-fix safe Ruby style issues
- `bundle exec brakeman` - Run security analysis

### CSS/Frontend
- `npm run build:css` - Build Tailwind CSS (one-time)
- `npm run build:css:watch` - Build Tailwind CSS with file watching
- `make build-css` - Build CSS via Docker

## Architecture

### Core Models
- `User` model with Devise authentication system
- Ready for deck building functionality (Cards, Decks, etc.)
- Home page with beautiful Tailwind CSS and DaisyUI styling
- Multi-environment database setup (development, test, production)

### Frontend Stack
- **CSS Framework**: Tailwind CSS with DaisyUI components
- **JavaScript**: Stimulus controllers with importmap
- **Views**: ERB templates with JSON support via jbuilder

### Testing Architecture
- **Framework**: RSpec with Rails integration
- **Test Data**: FactoryBot for fixtures and Faker for realistic data
- **Coverage**: SimpleCov with 70% minimum coverage requirement (enforced in CI)
- **Matchers**: Shoulda matchers for model validations
- **Parallel Testing**: Configured via parallel_tests gem
- **System Testing**: Capybara with Selenium WebDriver

### Database
- PostgreSQL 14 in development (via Docker on port 5433)
- Development URL: `postgresql://postgres:password@db:5432/proxyfield_development`
- Test URL: `postgresql://postgres:password@localhost:5432/proxyfield_test`

## Docker Configuration

The application runs in Docker with:
- Ruby 3.4.5 base image
- Node.js 22.x for frontend assets
- PostgreSQL 14 database container
- Volume mounting for live code updates

## Key Configuration Files

- `tailwind.config.js` - TailwindCSS + DaisyUI theming configuration
- `spec/rails_helper.rb` - Test setup with SimpleCov coverage reporting
- `Makefile` - Docker development commands
- `docker-compose.yml` - Container orchestration

## CI/CD Pipeline

The application includes GitHub Actions workflows:

### Test Pipeline (`.github/workflows/ci.yml`)
- Runs on Ruby 3.4.5 and Node.js 22
- Uses PostgreSQL 14 service container
- Executes full RSpec test suite with documentation format
- Enforces 70% minimum test coverage requirement
- Runs Brakeman security analysis
- Uploads coverage reports to Codecov (if token configured)

### Code Quality Pipeline (`.github/workflows/rubocop.yml`)
- Runs RuboCop linting with Rails Omakase rules
- Enforces consistent Ruby code style

Both pipelines run on pushes to main branch and pull requests targeting main.
