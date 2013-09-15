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

  get ':category/products' => "products#index", as: "products_index"
  resources :products, except: [:index]
  resources :cart, only: [:index] do
    collection do
      post 'add_item_to_cart'
      get 'checkout'
    end
    member do
      put 'change_cart_item_quantity'
      patch 'change_cart_item_quantity'
    end
  end

  resources :orders, only: [:create] do
    collection do
      get 'result'
    end
  end

  namespace :admin do
    get '/' => 'admin#index'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    get '/logout', to: 'sessions#destroy'

    resources :users
    resources :orders do
      member do
        get 'change_status'
      end
    end
    resources :products
    resources :news
    resources :faqs, only: [:index, :edit, :update]
    resources :banners, only: [:index, :edit, :update]
    resources :videos, only: [:index, :edit, :update]
  end
end
