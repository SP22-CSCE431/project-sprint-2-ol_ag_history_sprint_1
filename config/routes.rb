Rails.application.routes.draw do
  resources :lineages
  resources :events
  resources :members

  resources :calendar, only: [:show],controller: :calendar
  
  root "members#index"
  
  get "/members/:id" , to: "members#show"
  get "/lineages/:id" , to: "lineages#show"
  get "/events/:id", to: "events#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
