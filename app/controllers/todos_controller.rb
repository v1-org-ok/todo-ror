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

  private

  def todo_param
    params.require(:todo).permit(:title, :description, :is_done)
  end
end
