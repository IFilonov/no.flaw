Rails.application.routes.draw do
  devise_for :staffs, controllers: { sessions: 'staffs/sessions' }
  devise_for :females, controllers: { sessions: 'females/sessions' }
  devise_for :males, controllers: { sessions: 'males/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "application#index"
end
