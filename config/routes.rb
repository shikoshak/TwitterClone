Rails.application.routes.draw do

  #match ':controller(/:action/(:id))', :via => [:get, :post, :patch]
  devise_for :users
 resources :tweets
 root 'tweets#index'
  
end
