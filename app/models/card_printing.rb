class CardPrinting < ApplicationRecord
  belongs_to :card_set
  has_many :card_faces, dependent: :destroy

  has_one_attached :image_normal
  has_one_attached :image_art_crop

  validates :scryfall_id, :name, presence: true

  scope :by_name, ->(q) {
    next all if q.blank?

    where("name ILIKE ?", "%#{sanitize_sql_like(q)}%")
  }

  scope :by_set_code, ->(code) {
    next all if code.blank?

    joins(:card_set).where(card_sets: { code: code.to_s.upcase })
  }

  scope :legal_in, ->(format, status = "legal") {
    next all if format.blank?

    where("legalities ->> ? = ?", format.to_s, status)
  }

  scope :mana_between, ->(min_v, max_v) {
    rel = all
    rel = rel.where("mana_value >= ?", min_v) if min_v.present?
    rel = rel.where("mana_value <= ?", max_v) if max_v.present?
    rel
  }

  scope :with_color_identity_including, ->(colors) {
    next all if colors.blank?

    where("color_identity @> ARRAY[?]::varchar[]", Array(colors).map { |c| c.to_s.upcase })
  }

  scope :with_color_identity_exact, ->(colors) {
    next all if colors.blank?

    where("color_identity = ARRAY[?]::varchar[]", Array(colors).map { |c| c.to_s.upcase })
  }
end
