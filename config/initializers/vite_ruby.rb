ViteRuby.configure do |config|
  # Ensure ViteRuby can find assets in development
  config.mode = Rails.env.production? ? 'production' : 'development'
end

# Make sure ViteRuby helpers are available
Rails.application.config.to_prepare do
  ApplicationController.helper ViteRuby::Engine.helpers
end
