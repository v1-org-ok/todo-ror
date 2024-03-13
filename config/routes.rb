Rails.application.routes.draw do
  get 'todos', to: 'todos#index', as: 'todo_index'
  get 'todos/new', to: 'todos#new', as: 'todo_new'
  get 'todos/:id', to: 'todos#show', as: 'todo_show'

  post 'todos', to: 'todos#create', as: 'todo_create'
  # resources :todos
  root "todos#index"
end
