Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #トップページ
  root to: 'toppages#index'

  #ユーザ新規登録
  get '/signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]


  #ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout',to: 'sessions#destroy'

  # 投稿機能のルーティング
  # post '/posts', to: 'posts#create'
  # delete '/posts/:id'  , to: 'posts#destroy'


  resources :posts, only: [:create, :destroy]

  #不自然だがpost posts/idで決済する
  post '/posts/:id', to: 'posts#show'
  get '/posts/:id', to: 'posts#pay'

  #決済機能のルーティング
  post '/posts/:id/donate', to: 'toppages#donate'


end
