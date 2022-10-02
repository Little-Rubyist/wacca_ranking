Rails.application.routes.draw do
  root 'users#new'
  get 'sign_up' => "users#new"
  post 'sign_up' => "users#create"
  get 'sign_in' => "sessions#new"
  post 'sign_in' => "sessions#create"
  post 'sign_out' => "sessions#destroy"
  get 'how_to' => "users#how_to_import"
  resources :users, only: [:show, :update, :edit] do
    collection do
      post 'scraping' => :scraping
      get 'settings' => :setting
      post :import_score_from_html
      post :import_score_from_csv
    end
  end
  resources :user_songs, only: [:index, :show, :update] do
    collection do
      put '/:id/toggle_favorite' => :toggle_favorite
    end
  end
  resources :user_scores, only: [:new, :create, :destroy]
  resources :songs, only: [:show, :index]
  get 'home/index'
  get 'policies' => 'home#policies'
  get 'agreement' => 'home#agreement'
end
