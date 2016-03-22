Rails.application.routes.draw do
  root 'maps#index'

  get '/publications/review',       to: 'publications#review',  as: 'publication_review'

  resources :publications
  put '/publications/:id/approve',  to: 'publications#approve', as: 'approve_publication'
  put '/publications/:id/revoke',   to: 'publications#revoke',  as: 'revoke_publication'
end
