XTick::Application.routes.draw do

  root 'tickets#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :staffs, except: [:destroy]

  post '/', to: 'search#search'

  resources :tickets, except: [:show] do
    resources :ticket_histories, except: [:show, :destroy]
  end

  get 'ticket/:customer_link', to: 'ticket_histories#customer_link',  as: 'customer_link'

end
