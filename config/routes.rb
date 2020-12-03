Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :stories
    end
  end

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
  match '/search_suggestions', to: 'search_suggestions#index', via: :get
end
