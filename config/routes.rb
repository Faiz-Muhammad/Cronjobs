Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#index"
  resources :users
  get '/myaccounts', to: 'pages#index'
  resources :pages
  resources :posts

  get '/privacy_policy', to: 'static#privacy_policy'
  get '/terms_condition', to: 'static#terms_condition'
  get '/faqs', to: 'static#faqs'
  get '/payment_options', to: 'static#payment_options'

end
