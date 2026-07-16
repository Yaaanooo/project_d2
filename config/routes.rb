Rails.application.routes.draw do
  get 'admins/list'
  get 'admins/new'
  post 'admins/search'
  get 'search',to: 'admins#search'
# TOPとジャンル
  get "admins/genre", to: "admins#genre", as: :admin_genre

  patch "admins/genre", #既存データの更新
      to: "admins#update_genre",
      as: :admin_update_genre
  # post "admins/crerate"

  root 'games#top'
  get "games/top"
  get "games/quiz", to: "games#quiz", as: :game_quiz
  get 'games/result'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
end
