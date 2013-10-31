Hanchor::Application.routes.draw do  
  root to: 'welcome#index'
  get 'aboutus' => 'welcome#aboutus'
  get 'shopping_guide' => "welcome#shopping_guide"
  get 'faq' => 'welcome#faq'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :payment_notifications, only: [:create]

  resources :users, only: [:create,:update]

  resources :news do
    collection do
      get "list"
    end
  end

  get 'products/quantity' => "products#quantity"
  get 'products/:category' => "products#index", as: "products_index"
  get 'products/:category/:id' => "products#show", as: "products_show"


  get 'account' => "account#index"
  get 'account/info' => "account#info"
  get 'account/orders' => "account#orders"

  resources :paid_notify, only: [:create]
  
  get '/forget_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get '/confirm_password_reset', to: 'forgot_passwords#confirm_password_reset'

  resources :password_resets, only: [:show, :create]
  get '/invalid_token', to: 'password_resets#invalid_token'
  

  resources :cart, only: [:index] do
    collection do
      post 'add_item_to_cart'
      get 'checkout'
      get 'remove_cart_item'
      get 'check_out_shipping'
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
    resources :products do
      resources :product_colors, only: [:index, :destroy] do
        collection do
          post "create_update"
        end
      end
      resources :product_sizes, only: [:index, :destroy] do
        collection do
          post "create_update"
        end
      end
      resources :product_quantities, only: [:index, :create]
      resources :product_pics do
        collection { post :sort }
      end
    end
    resources :categories
    resources :news
    resources :shipping_costs, except: [:show]
    resources :faqs, only: [:index, :edit, :update]
    resources :banners, except: [:show]
    resources :videos, except: [:show]
  end
end
