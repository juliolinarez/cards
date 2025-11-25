class HomeController < ApplicationController
  # Skip authentication for the home page - it should be publicly accessible
  skip_before_action :authenticate_user!, only: [:index]

  def index
  end
end
