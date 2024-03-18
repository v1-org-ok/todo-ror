Rails.application.routes.draw do
  resources :todos
  get 'todos', to: 'todos#index', as: 'todo_index'

  patch 'todos/:id', to: 'todos#update', as: 'todo_update'
  put 'todos/:id', to: 'todos#update', as: 'todo_put'

  get 'todos/new', to: 'todos#new', as: 'todo_new'
  get 'todos/:id', to: 'todos#show', as: 'todo_show'

  get 'todos/:id/edit', to: 'todos#edit', as: 'todo_edit'
  post 'todos', to: 'todos#create', as: 'todo_create'
  delete 'todos/:id', to: 'todos#destroy', as: 'todo_delete'

  root "todos#index"
end
