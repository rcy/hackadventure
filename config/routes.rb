Hackadventure::Application.routes.draw do

  root :to => "adventures#index"

  resources :adventures
  resources :projects do
    resources :comments
  end
  resources :solutions

  resources :comments

end
