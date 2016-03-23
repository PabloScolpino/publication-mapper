Rails.application.routes.draw do
  root 'maps#index'

  get '/publications/review',       to: 'publications#review',  as: 'publication_review'

  resources :publications

  get '/publications/:id/approve',  to: 'publications#approve', as: 'approve_publication'
  get '/publications/:id/revoke',   to: 'publications#revoke',  as: 'revoke_publication'
end
