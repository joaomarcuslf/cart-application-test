Rails.application.routes.draw do
  get '/home', to: 'catalog#home'
  get '/product/:id', to: 'catalog#product'

  get '/cart', to: 'cart#index'
  get '/empty', to: 'cart#empty'
  get '/update', to: 'cart#update'
  post '/update', to: 'cart#update_cart'


  root to: 'catalog#home'
end
