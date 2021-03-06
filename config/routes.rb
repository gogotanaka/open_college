OpenCollege::Application.routes.draw do

  get "admin/control_panel"

  get "admin/user"

  get "admin/university"
  get "admin/new_school_subject"

  get "confirmations/new"

  get "password_resets/new"

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      post "outsides/analyze"
    end
  end
  
  resources :users do
    member do
      get :recommend, :source, :rank
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :class_room_for_years
  resources :class_rooms
  resources :class_grades, only: [:create, :destroy]
  resources :relation_class_room_users, only: [:create, :destroy]
  resources :teachers
  resources :password_resets
  resources :confirmations do
    member do
      get :send_mail
    end
  end

  resources :guides do
    member do
      get :intro, :reader, :finish
    end
  end

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  get "welcome/index"

  root :to => 'welcome#index'

end
