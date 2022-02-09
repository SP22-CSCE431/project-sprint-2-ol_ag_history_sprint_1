Rails.application.routes.draw do
  resources :lineages
  resources :events
  resources :members
  
  root "events#index"
  
  get "/members/:id" , to: "members#show"
  get "/lineages/:id" , to: "lineages#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
