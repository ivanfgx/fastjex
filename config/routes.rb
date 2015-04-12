Rails.application.routes.draw do
  resources :payment_schedules

  devise_for :users, controllers: { registrations: 'registrations' }
  root 'welcome#index'

  get '/dashboard' => 'dashboard#index', as: :dashboard
end
