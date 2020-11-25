Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, :controllers => {sessions: "sessions"}
  resources :users
  resources :team 
  get 'user_invite', action: :user_invite, controller: 'team'
  devise_scope :user do
		post '/users/invitation/new', to: 'invitations#invite_resource', as: :new_invite
 	end

end
