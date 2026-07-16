Rails.application.routes.draw do
  # ==========================================
  # アプリのルート（トップページ）
  # ==========================================
  root 'games#top'

  # ==========================================
  # Admins（管理者側）のルーティング
  # ==========================================
  # 一覧・検索・新規作成などの「固定パス」を先に書く（重要）
  get 'admins/list', to: 'admins#list', as: 'admins_list'
  get 'admins/search', to: 'admins#search', as: 'search'
  
  get 'admins/new', to: 'admins#new'
  post 'admins', to: 'admins#create'

  # ジャンル管理
  get "admins/genre", to: "admins#genre", as: :admin_genre
  patch "admins/genre", to: "admins#update_genre", as: :admin_update_genre

  # 更新・削除（「/:id」が含まれるものは他のパスと被らないよう下に書く）
  patch 'admins/:id', to: 'admins#update', as: 'update_admin'
  delete 'admins/:id', to: 'admins#destroy', as: 'destroy_admin'


  # ==========================================
  # Games（ゲーム・ユーザー側）のルーティング
  # ==========================================
  get "games/top"
  get "games/quiz", to: "games#quiz", as: :game_quiz
  get 'games/result'

  # quiz画面
  post "games/next", to: "games#next", as: :game_next
  post "games/back", to: "games#back", as: :game_back


  # ==========================================
  # その他（Rails標準）
  # ==========================================
  get "up" => "rails/health#show", as: :rails_health_check
end