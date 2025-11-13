class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary_entry

  validates :content, presence: { message: "コメントを入力してください。" }
end
