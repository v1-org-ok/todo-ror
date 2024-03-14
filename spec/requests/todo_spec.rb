require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let(:todo) { { title: "New Todo", description: "This is new todo", is_done: false } }
  describe "GET /index" do
    it "returns http success" do
      get todo_index_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'show specific todo' do
      todo = Todo.create(title: "Complete the task", description: "This is the description of task", is_done: false)
      get todo_show_url(todo)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    let(:todo_invalid) { { title: nil, description: "This is new todo", is_done: false } }

    it 'should add new Todo' do
      expect { post todo_create_url, params: { todo: todo } }.to change(Todo, :count).by(1)
    end

    it 'should not add new Todo with invalid params' do
      expect { post todo_create_url, params: { todo: todo_invalid } }.to change(Todo, :count).by(0)
    end

    it 'should redirect to todos page' do
      post todo_create_url, params: { todo: todo }
      expect(response).to redirect_to(todo_index_url)
    end

    it 'should not add todo in case of invalid data' do
      post todo_create_url, params: { todo: todo_invalid }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /update' do
    let(:todo) { { title: "This is title!", description: "This is Updated Description!", is_done: false } }
    let(:todo_updated) { { title: "This is updated!", description: "This is Updated Description!", is_done: true } }
    let(:invalid_todo_updated) { { title: nil, description: "This is Updated Description!", is_done: true } }

    before(:each) do
      @todo_obj = Todo.create! todo
    end

    it 'should update todo with valid params' do
      patch todo_update_url(@todo_obj), params: { todo: todo_updated }
      @todo_obj.reload

      expect(response).to redirect_to(todo_update_url)
      expect(@todo_obj.title).to eq("This is updated!")
      expect(@todo_obj.description).to eq("This is Updated Description!")
      expect(@todo_obj.is_done).to be(true)
    end

    it 'should not update todo with invalid params' do
      patch todo_update_url(@todo_obj), params: { todo: invalid_todo_updated }
      @todo_obj.reload

      expect(response).to have_http_status(422)
    end
  end
end
