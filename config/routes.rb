Rails.application.routes.draw do
  root 'home#index'
  get '/users/:address/nonce', to: 'users#nonce'

  get '/profile', to: 'users#profile', as: :profile
  get '/profile/edit', to: 'users#edit_profile', as: :edit_profile
  patch '/profile', to: 'users#update_profile'
  put '/profile', to: 'users#update_profile'
  get '/profile/public/:username', to: 'users#public_profile', as: :public_profile

  post '/sessions', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy', as: :destroy_user_session

  get '/wallet/nfts', to: 'wallet#nfts', as: :wallet_nfts
  get '/wallet/:username/nfts', to: 'wallet#public_nfts', as: :public_wallet

  get '/vault/nfts', to: 'vault#nfts', as: :vault_nfts
end
