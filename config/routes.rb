Rails.application.routes.draw do
  
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    get '/customers/restore' => "customers#restore", as: "restore"
    patch '/customers/withdrawal' => "customers#withdrawal", as: "withdrawal"
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    post '/orders/comfirm' => "orders#comfirm", as: "comfirm"
    get '/orders/complete' => "orders#complete", as: "complete"
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    root to: "homes#top"
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :order_detiles, only: [:update]

  end

  root to: "homes#top"
  get '/homes/about' => "homes#about", as: "about"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
