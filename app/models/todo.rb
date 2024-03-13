class Todo < ApplicationRecord
  validates :title, presence: true
  validates :is_done, inclusion: { in: [true, false] }
end
