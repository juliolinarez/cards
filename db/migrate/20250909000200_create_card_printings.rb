class CreateCardPrintings < ActiveRecord::Migration[8.0]
  def change
    create_table :card_printings do |t|
      t.uuid    :scryfall_id, null: false
      t.uuid    :oracle_id
      t.references :card_set, null: false, foreign_key: true
      t.string  :collector_number
      t.string  :lang

      t.citext  :name, null: false
      t.text    :oracle_text
      t.text    :flavor_text
      t.string  :type_line

      t.decimal :mana_value, precision: 6, scale: 2
      t.string  :mana_cost
      t.string  :power
      t.string  :toughness
      t.string  :loyalty

      t.string  :rarity
      t.string  :layout
      t.boolean :foil
      t.boolean :nonfoil
      t.boolean :promo
      t.boolean :digital
      t.boolean :reserved

      t.string  :scryfall_uri
      t.string  :rulings_uri
      t.string  :prints_search_uri
      t.string  :uri

      t.string  :illustration_id
      t.string  :artist

      t.string  :image_status

      t.string  :colors, array: true, default: []
      t.string  :color_identity, array: true, default: []
      t.string  :produced_mana, array: true, default: []

      t.jsonb   :prices, default: {}
      t.jsonb   :legalities, default: {}
      t.jsonb   :image_uris, default: {}
      t.jsonb   :related_uris, default: {}
      t.jsonb   :purchase_uris, default: {}
      t.jsonb   :all_data, default: {}

      t.date    :released_at

      t.timestamps
    end

    add_index :card_printings, :scryfall_id, unique: true
    add_index :card_printings, :oracle_id
    add_index :card_printings, :released_at
    add_index :card_printings, [:card_set_id, :collector_number]
    add_index :card_printings, :name, using: :gin, opclass: :gin_trgm_ops
    add_index :card_printings, :colors, using: :gin
    add_index :card_printings, :color_identity, using: :gin
    add_index :card_printings, :legalities, using: :gin
  end
end


