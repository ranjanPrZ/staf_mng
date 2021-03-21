Rails.application.routes.draw do
  resource :signup, only: %i[create]
  resources :authentications, only: %i[create]
  resources :users, only: %i[index]

  get '/archive_unarchive' =>'users#archive_unarchive'
  get '/login'=>'authentications#new'
  post '/login'=>'authentications#create'
  get '/logout' =>'authentications#destroy'
end
