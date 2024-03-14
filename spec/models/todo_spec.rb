require 'rails_helper'

RSpec.describe Todo, type: :model do
  let(:todo) { Todo.new(title: "Todo Title", description: "Todo Description", is_done: false) }

  describe '#save todo' do
    context 'when title is blank (invalid)' do
      let(:invalid_todo) { Todo.new(title: nil, description: "Todo Description", is_done: false) }
      it 'raise an error - validation failed (title)' do
        expect { invalid_todo.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Title can't be blank")
      end
    end

    context 'when is_done is missing (invalid)' do
      let(:invalid_todo) { Todo.new(title: "Todo Title", description: "Todo Description") }
      it 'raise an error - validation failed (is_done)' do
        expect { invalid_todo.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Is done is not included in the list")
      end
    end

    context 'when provided valid data' do
      it 'add todo to Todo list' do
        expect { todo.save! }.to_not raise_error
      end
    end
  end

  describe '#update todo' do
    context 'when provided valid data' do
      it 'update todo with new data' do
        todo = Todo.new(title: "Todo Title", description: "Todo Description", is_done: false)
        todo.save!

        saved_todo = Todo.find(todo.id)
        saved_todo.title = "Todo Title is the way to go"
        saved_todo.description = "Todo Description is the way to go"

        saved_todo.save!

        expect(saved_todo.title).to eq("Todo Title is the way to go")
        expect(saved_todo.description).to eq("Todo Description is the way to go")
      end
    end
  end
end
