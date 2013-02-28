Furioustypist::Application.routes.draw do
  devise_for :users

  resources :categories
  resources :tags
  resources :users, :only => [:index,
                              :show,
                              :edit,
                              :update,
                              :destroy]

  match "articles/ajaxcall" => "articles#ajaxcall", :via => [:get]

  resources :articles

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => "articles#index"
end
