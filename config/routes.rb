XTick::Application.routes.draw do

  root 'tickets#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :staffs

  post '/', to: 'search#search'

  resources :tickets do
    resources :ticket_histories
  end

  get 'ticket/:customer_link', to: 'ticket_histories#customer_link',  as: 'customer_link'

end
