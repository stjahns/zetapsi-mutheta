ZetapsiMutheta::Application.routes.draw do
  root "home#index"
  match ":action", :controller => "home", via: :get
end
