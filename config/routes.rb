Rails.application.routes.draw do
  get 'is_on_sell/index'
  get 'favorites/update'
  get 'favorites/index'
  get 'messages/index'
  get 'conversations/index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",:registrations => 'users/registrations' }
  devise_scope :user do
    get "users/profile"=> "users/registrations#profile", :as => "profile_registration"
  end
  devise_scope :product do
    get "products/isonsell"=> "products/isonsell", :as => "isonsell_product"
    get "products/markassell"=> "products/markassell", :as => "markassell_product"
    get "products/sellingnow"=> "products/sellingnow", :as => "sellingnow_product"
    get "products/reactive"=> "products/reactive", :as => "reactive_product"
    end
  #resources :products

  resources :products do
    collection do
      get :search
    end
  end  

  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
end
