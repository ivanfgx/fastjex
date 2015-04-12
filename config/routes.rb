Rails.application.routes.draw do
  resources :payment_schedules

  devise_for :users, controllers: { registrations: 'registrations' }
  root 'welcome#index'

  get '/dashboard' => 'dashboard#index', as: :dashboard
  get "/prepare/:id" => "payments#preapprovalkey"
  get "/subs/:id" => "payments#subscription"
  get "/payonce/:id" => "payments#pay"

  get "/succeed" => "payments#succeed"
end
