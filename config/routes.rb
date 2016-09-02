Rails.application.routes.draw do
  devise_for :investigators
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "complaints#index"

  get "complaints/new" => "complaints#new"

  post "complaints" => "create"

end
