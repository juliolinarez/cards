FactoryBot.define do
  factory :card_printing do
    association :card_set
    scryfall_id { SecureRandom.uuid }
    sequence(:name) { |n| "Card Printing #{n}" }
  end
end
