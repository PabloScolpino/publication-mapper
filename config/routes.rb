Rails.application.routes.draw do

  resources :tags
  resources :tags
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'maps#index'

  get '/publications/review',       to: 'publications#review',  as: 'publication_review'
  resources :publications
  get '/publications/:id/approve',  to: 'publications#approve', as: 'approve_publication'
  get '/publications/:id/revoke',   to: 'publications#revoke',  as: 'revoke_publication'
end
