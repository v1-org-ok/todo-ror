class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_param)

    if @todo.save
      redirect_to todo_index_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_param)
      redirect_to todo_show_url(@todo)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo = Todo.find(params[:id])

    if @todo.delete
      redirect_to todo_index_url
    else
      render :delete, status: :unprocessable_entity
    end
  end

  private

  def todo_param
    params.require(:todo).permit(:title, :description, :is_done)
  end
end
