Rails.application.routes.draw do
  root to: 'pages#home'
 
  devise_for :users, :controllers => {:sessions => "sessions"}
  resources :users do 
    get "users/new_avatar" => 'users#new_avatar', :as => :new_avatar
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
