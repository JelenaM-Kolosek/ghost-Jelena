Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { sessions: 'sessions' }
  resources :users do
    get "users/new_avatar" => 'users#new_avatar', :as => :new_avatar
    get 'invite', action: :user_invite
    get 'team', action: :team
  end
  devise_scope :user do
    post '/users/invitation/new', to: 'invitations#invite_resource', as: :new_invite
  end
  resources :stories
end
