Hanchor::Application.routes.draw do
  root to: 'welcome#index'
  get 'aboutus' => 'welcome#aboutus'
  get 'shopping_guide' => "welcome#shopping_guide"
  get 'faq' => 'welcome#faq'

  resources :news do
    collection do
      get "list"
    end
  end
end
