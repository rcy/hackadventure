Hackadventure::Application.routes.draw do

  devise_for :users

  root :to => "adventures#index"

  resources :adventures do
    resources :comments
  end
  resources :projects do
    resources :comments
  end
  resources :solutions do
    resources :comments
  end

  resources :comments

end
