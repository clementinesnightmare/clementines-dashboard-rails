require "sidekiq/web"
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root 'home#index'
  get '/users/:address/nonce', to: 'users#nonce'

  post '/sessions', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy', as: :destroy_user_session

  get '/wallet/nfts', to: 'wallet#nfts', as: :wallet_nfts

  get '/vault/nfts', to: 'vault#nfts', as: :vault_nfts

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end if Rails.env.production?

  mount Sidekiq::Web, at: "/sidekiq"
end
