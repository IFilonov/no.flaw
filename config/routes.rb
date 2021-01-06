Rails.application.routes.draw do
  devise_for :staffs, controllers: { sessions: 'staffs/sessions' }
  devise_for :females, controllers: { sessions: 'females/sessions' }
  devise_for :males, controllers: { sessions: 'males/sessions' }
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

  get '/staffs/logout', to: 'staffs#logout'
  get '/males/logout', to: 'males#logout'
  get '/females/logout', to: 'females#logout'

  constraints ->(req) { req.format == :json } do
    get '/staffs/info', to: 'staffs#info'
    get '/males/info', to: 'males#info'
    get '/females/info', to: 'females#info'
    post '/females/create', to: 'females#create'
    get '/females/delete', to: 'females#delete'
  end

  get '/males/*slug', to: 'males#index'
  get '/staffs/*slug', to: 'staffs#index'
  get '/females/*slug', to: 'females#index'
end
