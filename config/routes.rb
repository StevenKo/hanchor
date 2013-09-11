Hanchor::Application.routes.draw do
  root to: 'welcome#index'
  get 'aboutus' => 'welcome#aboutus'
  get 'shopping_guide' => "welcome#shopping_guide"
  get 'faq' => 'welcome#faq'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:create]

  resources :news do
    collection do
      get "list"
    end
  end

  get ':category/product' => "product#index", as: "product_index"
  resources :products, except: [:index]
end
