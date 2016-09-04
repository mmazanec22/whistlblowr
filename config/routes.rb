Rails.application.routes.draw do
  devise_for :investigators
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/testforms' => 'testforms#index'

  get '/complaints' => 'complaints#index'

  root "complaints#new"

  get "complaints/new" => "complaints#new"

  get 'complaints/find' => 'complaints#show', as: 'complaints_find'

  post "complaints" => "complaints#create"

  post 'messages' => 'messages#create', as: 'messages'

  put "complaints/:id" => "complaints#update", as: "update_complaint"


end
