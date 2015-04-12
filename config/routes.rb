Rails.application.routes.draw do
  resources :payment_schedules

  devise_for :users
  root 'welcome#index'

  get "/prepare/:id" => "payments#preapprovalkey"
  get "/subs/:id" => "payments#subscription"
  get "/payonce/:id" => "payments#pay"

  get "/succeed" => "payments#succeed"
end
