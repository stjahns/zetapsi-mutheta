ZetapsiMutheta::Application.routes.draw do

  root "home#index"

  resources :members
  resources :events

  # for static pages (home, about, contact)
  match ":action", :controller => "home", via: :get

end
