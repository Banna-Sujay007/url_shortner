Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'urls#new'
  get '/:short_url', to: 'urls#redirect', as: 'redirect'
  resources :urls, only: [:create]
end
