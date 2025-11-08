class DiaryEntry < ApplicationRecord
  belongs_to :user

  validates :title, presence: { message: "タイトルは必須です。" }
  validates :content, presence: { message: "内容は必須です。" }
end
