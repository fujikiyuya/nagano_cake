Rails.application.routes.draw do

  namespace :public do
    resources :addresses, only: [:index, :edit]
    resources :orders, only: [:new, :create, :index, :show]
    resources :cart_items, only: [:index, :update, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
  end

  namespace :admin do
    root to: "homes#top"
    resources :orders, only: [:show]
    resources :customers, only: [:index, :show, :edit]
    resources :items, only: [:new, :create, :index, :show, :edit]

  end

  root to: "homes#top"



  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
