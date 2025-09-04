# Sidekiq Setup and Usage

## Overview
This application uses Sidekiq for background job processing with Redis as the backend. Sidekiq runs in a separate Docker container alongside the main Rails application.

## Docker Services

### Development
- **Redis**: Runs on port 6379 (redis:7-alpine)
- **Sidekiq Worker**: Separate container processing background jobs
- **Rails App**: Main application container

### Production
- **Redis**: Runs on port 6380 with persistence enabled
- **Sidekiq Worker**: Production-optimized worker container

## Configuration Files

- `config/sidekiq.yml` - Main Sidekiq configuration (queues, concurrency, etc.)
- `config/initializers/sidekiq.rb` - Redis connection and middleware setup
- `docker-compose.yml` - Development Docker setup
- `docker-compose.production.yml` - Production Docker setup

## Queue Configuration

The following queues are configured with priorities:
1. **critical** (priority: 6) - For urgent jobs
2. **default** (priority: 4) - Standard jobs
3. **mailers** (priority: 3) - Email delivery jobs
4. **low** (priority: 2) - Low priority background tasks

## Starting Services

### Development
```bash
# Start all services (app, db, redis, sidekiq)
docker-compose up -d

# View Sidekiq logs
docker-compose logs -f sidekiq

# Stop all services
docker-compose down
```

### Production
```bash
# Start production services
docker-compose -f docker-compose.production.yml up -d

# View production Sidekiq logs
docker-compose -f docker-compose.production.yml logs -f sidekiq_prod
```

## Creating Background Jobs

### Example Job
```ruby
class ExampleJob < ApplicationJob
  queue_as :default

  def perform(arg1, arg2)
    # Job logic here
    Rails.logger.info "Processing job with #{arg1} and #{arg2}"
  end
end
```

### Enqueuing Jobs
```ruby
# Perform immediately in background
ExampleJob.perform_later(arg1, arg2)

# Schedule for later
ExampleJob.set(wait: 5.minutes).perform_later(arg1, arg2)

# Specific queue
ExampleJob.set(queue: :critical).perform_later(arg1, arg2)
```

## Web UI

The Sidekiq Web UI is available at `/sidekiq` when logged in as a user.

### Accessing the Web UI
1. Start the application
2. Sign in with your user account
3. Navigate to http://localhost:3000/sidekiq

The web UI is protected by Devise authentication.

## Testing Jobs

### Running Tests
```bash
# Test from Rails console
docker-compose exec app rails console

# Create your own test job
YourJob.perform_later(args)
```

## Monitoring

### Check Container Status
```bash
docker-compose ps
```

### View Sidekiq Logs
```bash
# All logs
docker-compose logs sidekiq

# Follow logs in real-time
docker-compose logs -f sidekiq

# Last 100 lines
docker-compose logs --tail=100 sidekiq
```

### Redis CLI Access
```bash
# Connect to Redis
docker-compose exec redis redis-cli

# Inside Redis CLI
> keys *
> info
```

## Environment Variables

- `REDIS_URL`: Redis connection string (default: `redis://localhost:6379/0`)
- `RAILS_ENV`: Environment (development/production/test)

## Troubleshooting

### Sidekiq Container Not Starting
1. Check logs: `docker-compose logs sidekiq`
2. Verify Redis is running: `docker-compose ps redis`
3. Check configuration syntax in `config/sidekiq.yml`

### Jobs Not Processing
1. Verify Sidekiq is connected to Redis
2. Check job queue names match configuration
3. Review Sidekiq Web UI for failed jobs

### Connection Issues
1. Ensure Redis container is healthy: `docker-compose ps`
2. Verify REDIS_URL environment variable
3. Check network connectivity between containers

## Performance Tuning

### Development
- Concurrency: 5 workers
- Max retries: 3
- Timeout: 60 seconds

### Production
- Concurrency: 10 workers
- Max retries: 5
- Timeout: 60 seconds
- Redis persistence enabled

Adjust these values in `config/sidekiq.yml` based on your needs.
