ZetapsiMutheta::Application.routes.draw do

  root "home#index"

  resources :members

  # for static pages (home, about, contact)
  match ":action", :controller => "home", via: :get

end
