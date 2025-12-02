require 'rails_helper'

RSpec.describe CardSet, type: :model do
  subject { build(:card_set) }

  it { should validate_presence_of(:scryfall_id) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:code) }

  it { should have_many(:card_printings).dependent(:destroy) }
end
