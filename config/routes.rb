Rails.application.routes.draw do
  	devise_for :admin_users, ActiveAdmin::Devise.config
  	ActiveAdmin.routes(self)
  	resources :products
	devise_for :users, controllers: {
	    registrations: 'users/registrations'
	  }
   	root 'products#index'
end
