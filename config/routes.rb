TopDashboard::Application.routes.draw do
   resources :sessions, only: [:new, :create, :destroy]
   resources :students
   resources :users, only: [:show,:new]
   resources :time_logs, only: [:index, :new, :edit]

   get '/profile', to: 'users#show'
   get '/sign_up', to: 'users#new'
   get '/sign_in', to: 'sessions#new'
   get '/sign_out', to: 'sessions#destroy'
   root 'welcome#index'

end
