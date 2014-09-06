DropboxAnalytics::Application.routes.draw do
  root 'home#index'
  
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :nodes do
    collection do
      post 'update'
    end
  end
end
