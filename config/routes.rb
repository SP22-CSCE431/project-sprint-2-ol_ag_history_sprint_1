# frozen_string_literal: true

Rails.application.routes.draw do
  resources :attendances do
    collection do
      match 'search' => 'attendances#search', via: [:get, :post], as: :search
    end
  end
  resources :dues do
    collection do
      match 'search' => 'dues#search', via: [:get, :post], as: :search
    end
  end
  resources :lineages
  resources :events
  resources :members

  resources :calendar, only: [:show],controller: :calendar
  
  #root "members#index"
  
  get "/members/:id" , to: "members#show"
  get "/lineages/:id" , to: "lineages#show"
  resources :members, :lineages, :events
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get '/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get '/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
    get "/members/:id" , to: "members#show"
    get "/lineages/:id" , to: "lineages#show"
    root "dashboards#show"
  end

  get "/events/:id", to: "events#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
