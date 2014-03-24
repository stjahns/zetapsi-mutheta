ZetapsiMutheta::Application.routes.draw do

  devise_for :members
  devise_scope :member do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy"
  end

  mount Mercury::Engine => '/'

  root "home#index"

  resources :members, except: [:new]
  resources :invitations, only: [:create, :destroy]
  resources :events

  resources :pages, param: :name, except: [:new] do
    member { put :mercury_update }
  end

  put '/content/:name', to: 'home#mercury_update', as: 'update_content'

  resources :albums do
    resources :album_photos
  end

  get 'members/:id/confirm' => 'members#new'

  # for static pages (home, about, contact)
  match ":action", :controller => "home", via: :get

end
