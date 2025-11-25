class CardFace < ApplicationRecord
  belongs_to :card_printing

  has_one_attached :image_normal
  has_one_attached :image_art_crop

  validates :index, presence: true
end
