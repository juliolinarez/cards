class CardSet < ApplicationRecord
  has_many :card_printings, dependent: :destroy

  validates :scryfall_id, :code, :name, presence: true
  validates :code, uniqueness: true
end
