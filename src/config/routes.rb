Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get 'about' => 'pages#about'
  get 'result' => 'pages#result'
  get 'search' => 'pages#search'
  get 'test' => 'pages#test'
  get 'profile' => 'pages#profile'
  post 'add' => 'pages#add'
  post 'update_handle_to_db' => 'database#update_handle_to_db'
  post 'add_links_to_db' => 'database#add_links_to_db'
  post 'remove_links_from_db' => 'database#remove_links_from_db'
  post 'add_friends_to_db' => 'database#add_friends_to_db'
  post 'remove_friends_from_db' => 'database#remove_friends_from_db'
  post 'add_contest_to_db' => 'database#add_contest_to_db'
  post 'remove_contest_from_db' => 'database#remove_contest_from_db'
  post 'profile' => 'pages#profile'
  post 'retrieve_solved' => 'pages#retrieve_solved'
  post 'retrieve_attempted' => 'pages#retrieve_attempted'
  post 'retrieve_handle' => 'pages#retrieve_handle'
  post 'retrieve_compare_icon_path' => 'pages#retrieve_compare_icon_path'
  post 'retrieve_cancel_icon_path' => 'pages#retrieve_cancel_icon_path'
end