FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 2).chomp('.').truncate(255) }
    content { Faker::Lorem.paragraph(sentence_count: 5, supplemental: false, random_sentences_to_add: 3) }

    # Factory con datos específicos para testing
    trait :with_specific_data do
      title { "Sample Post Title" }
      content { "This is a sample post content for testing purposes with enough characters." }
    end

    # Factory para posts con títulos largos
    trait :with_long_title do
      title { Faker::Lorem.sentence(word_count: 15, supplemental: false).chomp('.').truncate(255) }
    end

    # Factory para posts con contenido largo
    trait :with_long_content do
      content { Faker::Lorem.paragraphs(number: 5, supplemental: false).join("\n\n") }
    end

    # Factory para posts con títulos cortos pero válidos
    trait :with_short_title do
      title { Faker::Lorem.words(number: 2, supplemental: false).join(' ').titleize.ljust(3, 'x') }
    end

    # Factory para posts con contenido corto pero válido
    trait :with_short_content do
      content { Faker::Lorem.sentence(word_count: 10, supplemental: false).ljust(10, ' more text') }
    end

    # Factory para posts con datos inválidos (para testing de validaciones)
    trait :invalid do
      title { "" }
      content { "" }
    end

    # Factory para posts con solo título vacío
    trait :without_title do
      title { "" }
    end

    # Factory para posts con solo contenido vacío
    trait :without_content do
      content { "" }
    end

    # Factory para título demasiado corto
    trait :title_too_short do
      title { "Hi" }
    end

    # Factory para contenido demasiado corto
    trait :content_too_short do
      content { "Short" }
    end
  end
end
