class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 255 }
  validates :content, presence: true, length: { minimum: 10 }
end
