class CreateCardSets < ActiveRecord::Migration[8.0]
  def change
    create_table :card_sets do |t|
      t.uuid    :scryfall_id, null: false
      t.string  :code, null: false
      t.string  :name, null: false
      t.date    :released_at
      t.string  :set_type
      t.integer :card_count
      t.string  :parent_set_code
      t.string  :icon_svg_uri
      t.string  :search_uri
      t.jsonb   :data, null: false, default: {}

      t.timestamps
    end

    add_index :card_sets, :scryfall_id, unique: true
    add_index :card_sets, :code, unique: true
    add_index :card_sets, :released_at
  end
end


