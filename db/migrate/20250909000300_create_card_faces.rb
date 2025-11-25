class CreateCardFaces < ActiveRecord::Migration[8.0]
  def change
    create_table :card_faces do |t|
      t.references :card_printing, null: false, foreign_key: true
      t.integer :index, null: false, default: 0

      t.citext :name
      t.string :mana_cost
      t.string :type_line
      t.text   :oracle_text
      t.text   :flavor_text

      t.string :power
      t.string :toughness
      t.string :loyalty

      t.string :colors, array: true, default: []
      t.jsonb  :image_uris, default: {}

      t.string :illustration_id
      t.string :artist

      t.timestamps
    end

    add_index :card_faces, [ :card_printing_id, :index ], unique: true
    add_index :card_faces, :name, using: :gin, opclass: :gin_trgm_ops
    add_index :card_faces, :colors, using: :gin
  end
end
