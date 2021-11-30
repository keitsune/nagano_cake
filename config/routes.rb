Rails.application.routes.draw do



  devise_for :customers, path:""
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
  end

  scope module: :public do
    root 'homes#top'
    resource :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
<<<<<<< HEAD
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    put "customers/withdraw" => "customers#withdraw"
=======
    get "customers/unsubscribe" => "public/customers#unsubscribe"
>>>>>>> 0c8883a683847de0535243a6a51641cdef56f7ed
  end
end