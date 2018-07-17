Rails.application.routes.draw do
  	devise_for :admin_users, ActiveAdmin::Devise.config
  	ActiveAdmin.routes(self)
  	resources :products
  	get 'products/:id/buy', to: 'products#buy', as: 'buy_product'
  	get 'your/products', to: 'products#your', as: 'your_products'
  	get 'bought/products', to: 'products#bought', as: 'bought_products'
	devise_for :users, controllers: {
	    registrations: 'users/registrations'
	  }
   	root 'products#index'
end
