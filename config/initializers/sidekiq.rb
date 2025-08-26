# Sidekiq configuration
require "sidekiq"

# Configure Sidekiq server
Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0"),
    network_timeout: 5,
    pool_timeout: 5
  }

  # Server middleware
  config.server_middleware do |chain|
    # Add any server middleware here
  end

  # Client middleware
  config.client_middleware do |chain|
    # Add any client middleware here
  end

  # Error handling
  config.error_handlers << proc do |exception, context_hash|
    # Log errors to Rails logger
    Rails.logger.error "Sidekiq error: #{exception.message}"
    Rails.logger.error exception.backtrace.join("\n") if exception.backtrace
  end

  # Death handlers
  config.death_handlers << proc do |job, exception|
    Rails.logger.error "Job died: #{job['class']} - #{exception.message}"
  end
end

# Configure Sidekiq client
Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0"),
    network_timeout: 5,
    pool_timeout: 5,
    size: 1
  }

  # Client middleware
  config.client_middleware do |chain|
    # Add any client middleware here
  end
end

# Configure Sidekiq logging
if defined?(Sidekiq.logger)
  Sidekiq.logger.level = Rails.logger.level
end
