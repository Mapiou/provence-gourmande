Rails.application.routes.draw do
  get 'restaurant/index'
  get 'restaurant/show'
  get 'restaurant/new'
  get 'restaurant/edit'
  get 'restaurant/create'
  get 'restaurant/update'
  get 'restaurant/destroy'
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
