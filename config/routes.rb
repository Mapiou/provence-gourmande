Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  resources :restaurants do
    resources :restaurant_reviews
  end

  resources :recipes do
    resources :recipe_reviews, only: [:create]
  end

end
