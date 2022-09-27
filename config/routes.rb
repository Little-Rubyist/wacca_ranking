Rails.application.routes.draw do
  root 'users#new'
  get 'sign_up' => "users#new"
  post 'sign_up' => "users#create"
  get 'sign_in' => "sessions#new"
  post 'sign_in' => "sessions#create"
  post 'sign_out' => "sessions#destroy"
  get 'how_to' => "users#how_to_import"
  resource :user, only: [:show, :update, :edit] do
    collection do
      post 'scraping' => :scraping
      get 'settings' => :setting
      post :import_score_from_html
    end
  end
  resources :songs, only: [:show, :index]
end
