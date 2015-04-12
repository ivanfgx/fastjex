Rails.application.routes.draw do
  resources :payment_schedules

  devise_for :users
  root 'welcome#index'
end
