DropboxAnalytics::Application.routes.draw do
  root 'home#index'
  
  # Omniauth callback
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get 'stats', to: 'stats#index'

  resources :nodes do
    collection do
      get 'contents_for_path'
    end
  end
end
