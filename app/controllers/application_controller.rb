class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # Disabled in test environment to avoid 403 errors in tests
  unless Rails.env.test?
    allow_browser versions: :modern
  end
end
