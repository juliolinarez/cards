require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users

  # Sidekiq Web UI (protected by Devise authentication)
  authenticate :user do
    mount Sidekiq::Web => "/sidekiq"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Sidekiq health check endpoint (protected by authentication)
  authenticate :user do
    post "sidekiq/health_check" => "sidekiq_health#check", as: :sidekiq_health_check
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Hotwire test routes
  get "hotwire-test", to: "hotwire_test#index", as: :hotwire_test
  post "hotwire-test/button-one", to: "hotwire_test#button_one", as: :hotwire_test_button_one
  post "hotwire-test/button-two", to: "hotwire_test#button_two", as: :hotwire_test_button_two
  post "hotwire-test/button-three", to: "hotwire_test#button_three", as: :hotwire_test_button_three
  post "hotwire-test/reset", to: "hotwire_test#reset_counter", as: :hotwire_test_reset

  # Defines the root path route ("/")
  root "home#index"
end
