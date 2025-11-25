require 'rails_helper'

RSpec.describe CardFace, type: :model do
  subject { build(:card_face, card_printing: build(:card_printing, card_set: build(:card_set))) }

  it { should belong_to(:card_printing) }
  it { should validate_presence_of(:index) }
  # Attachments presence is managed by Active Storage, but you can test association exists
  it { should respond_to(:image_normal) }
  it { should respond_to(:image_art_crop) }
end
