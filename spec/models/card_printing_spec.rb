require 'rails_helper'

RSpec.describe CardPrinting, type: :model do
  subject { build(:card_printing) }

  it { should belong_to(:card_set) }
  it { should have_many(:card_faces).dependent(:destroy) }

  it { should validate_presence_of(:scryfall_id) }
  it { should validate_presence_of(:name) }

  # Attachment presence cannot be tested with shoulda-matchers by default, but you could add custom checks for attached images as needed.

  describe 'scopes' do
    # Example: by_name returns printing by substring matching
    let!(:printing1) { create(:card_printing, name: 'Fireball') }
    let!(:printing2) { create(:card_printing, name: 'Lightning Bolt') }

    it 'by_name returns relevant records' do
      expect(described_class.by_name('Fire')).to include(printing1)
      expect(described_class.by_name('Fire')).not_to include(printing2)
    end
  end
end
