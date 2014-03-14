ZetapsiMutheta::Application.routes.draw do

  mount Mercury::Engine => '/'
  root "home#index"

  resources :sessions, only: [:new, :create, :destroy]
  resources :members, except: [:new]
  resources :invitations, only: [:create, :destroy]
  resources :events

  resources :albums do
    resources :album_photos
  end

  get 'members/:id/confirm' => 'members#new'

  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'

  # for static pages (home, about, contact)
  match ":action", :controller => "home", via: :get

end
