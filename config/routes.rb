Rails.application.routes.draw do
  devise_for :users
  resources :players, except: [:show]

  root to: "players#index"
 end
