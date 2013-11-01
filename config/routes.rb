SimpleTypex::Engine.routes.draw do
  
  resources :types

  root :to => 'types#index'
end
