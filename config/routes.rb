Rails.application.routes.draw do
  root 'surveys#index'

  namespace :api do
    namespace :v1 do
      get 'surveys/index'
      post 'surveys/create'
      delete 'surveys/:id', to: 'surveys#destroy'
    end
  end

  get '*path', to: 'surveys#index', via: :all
end
