Rails.application.routes.draw do
  namespace :public do
    root to: "homes#top"
  end
  namespace :admin do
    get "admin/homes/top" => "admin#homes#top"
  end
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customers,skip: [:passwords], contollers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
