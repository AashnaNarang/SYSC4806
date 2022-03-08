Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'surveys/index'
      post 'surveys/create'
      delete 'surveys/:id', to: 'surveys#destroy'
      
      get 'mc_questions/index'
      get 'mc_questions/:id', to: 'mc_questions#show'
      post 'mc_questions/create'
      delete 'mc_questions/:id', to: 'mc_questions#destroy'
      patch 'mc_questions/:id', to: 'mc_questions#update'
    end
  end


  # Root path to enter the react application
  root 'survey#index'
end
