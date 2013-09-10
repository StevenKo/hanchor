Hanchor::Application.routes.draw do
  root to: 'welcome#index'
  get 'aboutus' => 'welcome#aboutus'
end
