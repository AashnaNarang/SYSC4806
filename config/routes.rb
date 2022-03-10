Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'surveys/index'
      get 'surveys/:id', to: 'surveys#show'
      post 'surveys/create'
      patch 'surveys/:id', to: 'surveys#update'
      delete 'surveys/:id', to: 'surveys#destroy'
      
      post 'text_questions/create', to: 'text_questions#create'
      get 'text_questions/:id', to: 'text_questions#show'
      patch 'text_questions/:id', to: 'text_questions#update'
      delete 'text_questions/:id', to: 'text_questions#destroy'

      get 'mc_questions/:id', to: 'mc_questions#show'
      post 'mc_questions/create'
      delete 'mc_questions/:id', to: 'mc_questions#destroy'
      patch 'mc_questions/:id', to: 'mc_questions#update'
    end
  end

  get '*path', to: 'surveys#index', via: :all

  # Root path to enter the react application
  root 'surveys#index'
end
