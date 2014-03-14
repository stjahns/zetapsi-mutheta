ZetapsiMutheta::Application.routes.draw do

  root "home#index"

  resources :members, except: [:new]
  resources :invitations, only: [:create, :destroy]
  resources :events

  resources :albums do
    resources :album_photos
  end

  # for static pages (home, about, contact)
  match ":action", :controller => "home", via: :get


  get 'members/:id/confirm' => 'members#new'

end
