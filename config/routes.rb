Animephile::Application.routes.draw do
  root :to => 'comics#index'
  
  resources :comics do
    resources :pages 
  end
end
