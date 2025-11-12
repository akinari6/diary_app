class DiaryEntry < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: { message: "タイトルは必須です。" }
  validates :content, presence: { message: "内容は必須です。" }
end
