Rails.application.routes.draw do
  root 'maps#index'
  #get '/publications' => 'publications#index'
  resources :publications
end
