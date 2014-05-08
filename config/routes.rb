ChessCamp::Application.routes.draw do
  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps
  resources :students
  resources :families
  resources :locations
  resources :registrations
  resources :users
  resources :sessions
  resources :payments
  
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy

  # set the root url
  root to: 'home#index'

end
