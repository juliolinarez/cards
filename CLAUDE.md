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

### Testing
- `bundle exec rspec` - Run all tests
- `bundle exec rspec spec/models/user_spec.rb` - Run specific test file
- `bundle exec rspec spec/models/user_spec.rb:10` - Run specific test line
- `bundle exec parallel_rspec spec/` - Run tests in parallel

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
- **Test Data**: FactoryBot for fixtures
- **Coverage**: SimpleCov with 80% minimum coverage requirement
- **Matchers**: Shoulda matchers for model validations
- **Parallel Testing**: Configured via parallel_tests gem

### Database
- PostgreSQL in development (via Docker)
- Database URL: `postgresql://postgres:password@db:5433/proxyfield_development`

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
