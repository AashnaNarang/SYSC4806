Rails.application.routes.draw do
  root 'surveys#index'

  namespace :api do
    namespace :v1 do
      get 'surveys/index'
      post 'surveys/create'
      patch 'surveys/:id', to: 'surveys#update'
      delete 'surveys/:id', to: 'surveys#destroy'
      
      get 'mc_questions/:id', to: 'mc_questions#show'
      post 'mc_questions/create'
      delete 'mc_questions/:id', to: 'mc_questions#destroy'
      patch 'mc_questions/:id', to: 'mc_questions#update'
    end
  end

  get '*path', to: 'surveys#index', via: :all
end
