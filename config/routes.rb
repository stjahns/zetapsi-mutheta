ZetapsiMutheta::Application.routes.draw do

  root "home#index"

  resources :members
  resources :events

  resources :albums do
    resources :album_photos
  end

  # for static pages (home, about, contact)
  match ":action", :controller => "home", via: :get

end
