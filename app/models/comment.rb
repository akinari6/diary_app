class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary_entry

  validates :content, presence: true
end
