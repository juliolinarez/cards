FactoryBot.define do
  factory :card_set do
    scryfall_id { SecureRandom.uuid }
    sequence(:code) { |n| "SET#{n}" }
    sequence(:name) { |n| "Card Set #{n}" }
  end
end
