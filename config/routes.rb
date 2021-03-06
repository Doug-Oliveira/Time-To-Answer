Rails.application.routes.draw do

  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    #com / o argumento ja é recebido no controller como subject_id
    get 'subject/:subject_id', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
  end
  
  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
  end

  namespace :admins_backoffice do
    get 'welcome/index' #Dashboard
    resources :admins
    resources :subjects
    resources :questions
  end
  
  #skip exclui rota para registrar novos admins 
  devise_for :admins, skip: [:registrations]
  devise_for :users
  
  get 'inicio', to: 'site/welcome#index'

  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
