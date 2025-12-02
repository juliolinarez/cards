FactoryBot.define do
  factory :card_face do
    association :card_printing
    sequence(:index) { |n| n }
  end
end
