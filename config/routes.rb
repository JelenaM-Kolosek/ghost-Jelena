Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { sessions: 'sessions' }
  resources :users do
    get 'invite', action: :user_invite
    get 'team', action: :team
  end
  devise_scope :user do
    post '/users/invitation/new', to: 'invitations#invite_resource', as: :new_invite
  end
  resources :stories
  get 'site_overview', to: 'stories#site_overview', as: :site_overview
  match '/search_suggestions', to: 'search_suggestions#index', via: :get
end
