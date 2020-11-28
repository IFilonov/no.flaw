Rails.application.routes.draw do
  devise_for :females
  devise_for :males
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "application#index"
end
