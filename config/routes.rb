Rails.application.routes.draw do
  devise_for :investigators
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/testforms' => 'testforms#index'

  get '/complaints' => 'complaints#index'

  root "complaints#new"

  get "complaints/new" => "complaints#new"

  get 'complaints/find' => 'complaints#show'

  post "complaints" => "complaints#create"

  post 'messages' => 'messages#create', as: 'complaint_messages'

  put "complaints/:id/edit" => "complaints#update", as: "edit_complaint"


end
