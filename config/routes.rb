Hackadventure::Application.routes.draw do

  resources :project_prereqs

  devise_for :users

  root :to => "users#index"

  resources :adventures do
    resources :comments
  end
  resources :projects do
    resources :comments
    post :mark_complete, :on => :member
    post :unmark_complete, :on => :member
  end
  resources :solutions do
    resources :comments
  end

  resources :comments

end
