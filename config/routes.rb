DropboxAnalytics::Application.routes.draw do
  root 'home#index'
  
  # Omniauth callback
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get 'stats', to: 'stats#index'
  get 'stats/:path', constraints: { path: /.*/ }, to: 'stats#index'

  resources :nodes do
    collection do
      get 'stats'
      get 'sidebar'
      get 'file_list'
    end
  end
end
