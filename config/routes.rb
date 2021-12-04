Rails.application.routes.draw do
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  scope module: :public do
    root 'homes#top'
    get "about" => "homes#about"
    resource :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    put "customers/withdraw" => "customers#withdraw"
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
  end


  devise_for :customers,skip: [:passwords,], controllers: {
  registrations: "publics/registrations",
  sessions: 'publics/sessions'
}

  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
  end


end