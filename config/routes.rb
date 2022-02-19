Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'surveys/index'
      post 'surveys/create'
      delete 'surveys/:id', to: 'surveys#destroy'
    end
  end


  # Root path to enter the react application
  root 'survey#index'
end
