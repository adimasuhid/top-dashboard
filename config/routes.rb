TopDashboard::Application.routes.draw do
   resources :sessions, only: [:new, :create, :destroy]
   resources :students

   get '/signin', to: 'sessions#new'
   root 'welcome#index'

end
