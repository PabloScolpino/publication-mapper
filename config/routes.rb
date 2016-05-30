Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'publications#map'

  get '/publications/review',       to: 'publications#review',  as: 'publication_review'
  resources :publications
  get '/publications/:id/approve',  to: 'publications#approve', as: 'approve_publication'
  get '/publications/:id/revoke',   to: 'publications#revoke',  as: 'revoke_publication'
  resources :about_us
  resources :tags

  mount Attachinary::Engine => "/attachinary"
end
