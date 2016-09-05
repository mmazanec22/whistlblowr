Rails.application.routes.draw do
  devise_for :admins
  devise_for :investigators, :path_prefix =>'auth'
  # devise_for :users
  scope "/admin" do
    resources :investigators  #(possibly add this too?-> ), :path_prefiex =>'auth'
  #  https://github.com/plataformatec/devise/wiki/How-To:-Manage-users-through-a-CRUD-interface
  end

  # or this looks promising http://stackoverflow.com/questions/7075873/devise-how-to-create-a-new-user-being-already-logged-in


  # #instructions to bypass devise ----------------------------
  # resources :investigators, except: :create
  # get 'investigator/new' => "investigator#new"
  #   # Name it however you want
  # post 'create_investigator' => 'investigators#create', as: :create_investigator
  # # end devise bypass -------------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/testforms' => 'testforms#index'

  get '/complaints' => 'complaints#index'

  root "complaints#new"

  get "complaints/new" => "complaints#new"

  get 'complaints/find' => 'complaints#show', as: 'complaints_find'

  post "complaints" => "complaints#create"

  post 'messages' => 'messages#create', as: 'messages'

  put "complaints/:id/edit" => "complaints#update", as: "edit_complaint"




end
