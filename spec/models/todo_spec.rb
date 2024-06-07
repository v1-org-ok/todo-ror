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


  describe 'update' do
    before do
      @todo = Todo.create(title: 'Initial Title', description: 'Initial Description', is_done: false)
    end

    context 'with valid attributes' do
      it 'updates the todo' do
        @todo.update(title: 'Updated Title', description: 'Updated Description', is_done: true)

        expect(@todo).to be_valid
        expect(@todo.title).to eq('Updated Title')
        expect(@todo.description).to eq('Updated Description')
        expect(@todo.is_done).to be true
      end
    end

    context 'with invalid attributes' do
      it 'does not update the todo' do
        @todo.update(title: nil) # Assuming title is required

        expect(@todo).not_to be_valid
        expect(@todo.errors[:title]).to include("can't be blank")
      end
    end
  end

end
