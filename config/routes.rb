Rails.application.routes.draw do
  root 'maps#index'
  #get '/publications' => 'publications#index'
  resources :publications
  put '/publications/:id/approve' => 'publications#approve'
  get '/publications/:id/approve' => 'publications#approve'
  put '/publications/:id/revoke' => 'publications#revoke'
  get '/publications/:id/revoke' => 'publications#revoke'
end
