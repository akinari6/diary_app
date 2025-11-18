class Tag < ApplicationRecord
  has_many :diary_tags, dependent: :destroy
  has_many :diary_entries, through: :diary_tags
end
