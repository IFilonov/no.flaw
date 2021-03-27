Rails.application.routes.draw do
  constraints ->(req) { req.format == :html } do
    devise_for :staffs, controllers: { sessions: 'staffs/sessions' }
    devise_for :females, controllers: { sessions: 'females/sessions' }
    devise_for :males, controllers: { sessions: 'males/sessions' }
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  authenticated :male do
    root 'males#index', as: :authenticated_male
  end
  authenticated :female do
    root 'females#index', as: :authenticated_female
  end
  authenticated :staff do
    root 'staffs#index', as: :authenticated_staff
  end

  root to: "application#index"

  %w[staffs females males].each do |user|
    get "/#{user}/logout", to: "#{user}#logout"
  end

  constraints ->(req) { req.format == :json } do
    resources :pairs, only: [:index, :update, :destroy]

    resources :males, only: [:create]
    resources :females, only: [:create]

    resources :tasks, only: [:index]

    get '/staffs/info', to: 'staffs#info'

    get '/males/info', to: 'males#info'
    get '/males/dates', to: 'males#dates'
    post '/males/update', to: 'males#update'
    post '/lifetimes/set_fire_date', to: 'lifetimes#set_fire_date'

    get '/females/info', to: 'females#info'
    get '/females/dates', to: 'females#dates'
    post '/females/update', to: 'females#update'
    post '/lifetimes/set_taboo_date', to: 'lifetimes#set_taboo_date'
    post '/lifetimes/set_fire_date', to: 'lifetimes#set_fire_date'

    get '/pairs/delete', to: 'pairs#delete'
    post '/pairs/restore', to: 'pairs#restore'
  end

  get '/males/*slug', to: 'males#index'
  get '/staffs/*slug', to: 'staffs#index'
  get '/females/*slug', to: 'females#index'
end
