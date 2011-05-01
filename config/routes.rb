Hackadventure::Application.routes.draw do
  root :to => "adventures#index"

  resources :adventures
  resources :projects
  resources :solutions

end
