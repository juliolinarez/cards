# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_09_000300) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_trgm"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "card_faces", force: :cascade do |t|
    t.bigint "card_printing_id", null: false
    t.integer "index", default: 0, null: false
    t.citext "name"
    t.string "mana_cost"
    t.string "type_line"
    t.text "oracle_text"
    t.text "flavor_text"
    t.string "power"
    t.string "toughness"
    t.string "loyalty"
    t.string "colors", default: [], array: true
    t.jsonb "image_uris", default: {}
    t.string "illustration_id"
    t.string "artist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_printing_id", "index"], name: "index_card_faces_on_card_printing_id_and_index", unique: true
    t.index ["colors"], name: "index_card_faces_on_colors", using: :gin
    t.index ["name"], name: "index_card_faces_on_name", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "card_printings", force: :cascade do |t|
    t.uuid "scryfall_id", null: false
    t.uuid "oracle_id"
    t.bigint "card_set_id", null: false
    t.string "collector_number"
    t.string "lang"
    t.citext "name", null: false
    t.text "oracle_text"
    t.text "flavor_text"
    t.string "type_line"
    t.decimal "mana_value", precision: 6, scale: 2
    t.string "mana_cost"
    t.string "power"
    t.string "toughness"
    t.string "loyalty"
    t.string "rarity"
    t.string "layout"
    t.boolean "foil"
    t.boolean "nonfoil"
    t.boolean "promo"
    t.boolean "digital"
    t.boolean "reserved"
    t.string "scryfall_uri"
    t.string "rulings_uri"
    t.string "prints_search_uri"
    t.string "uri"
    t.string "illustration_id"
    t.string "artist"
    t.string "image_status"
    t.string "colors", default: [], array: true
    t.string "color_identity", default: [], array: true
    t.string "produced_mana", default: [], array: true
    t.jsonb "prices", default: {}
    t.jsonb "legalities", default: {}
    t.jsonb "image_uris", default: {}
    t.jsonb "related_uris", default: {}
    t.jsonb "purchase_uris", default: {}
    t.jsonb "all_data", default: {}
    t.date "released_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_set_id", "collector_number"], name: "index_card_printings_on_card_set_id_and_collector_number"
    t.index ["color_identity"], name: "index_card_printings_on_color_identity", using: :gin
    t.index ["colors"], name: "index_card_printings_on_colors", using: :gin
    t.index ["legalities"], name: "index_card_printings_on_legalities", using: :gin
    t.index ["name"], name: "index_card_printings_on_name", opclass: :gin_trgm_ops, using: :gin
    t.index ["oracle_id"], name: "index_card_printings_on_oracle_id"
    t.index ["released_at"], name: "index_card_printings_on_released_at"
    t.index ["scryfall_id"], name: "index_card_printings_on_scryfall_id", unique: true
  end

  create_table "card_sets", force: :cascade do |t|
    t.uuid "scryfall_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.date "released_at"
    t.string "set_type"
    t.integer "card_count"
    t.string "parent_set_code"
    t.string "icon_svg_uri"
    t.string "search_uri"
    t.jsonb "data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_card_sets_on_code", unique: true
    t.index ["released_at"], name: "index_card_sets_on_released_at"
    t.index ["scryfall_id"], name: "index_card_sets_on_scryfall_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "card_faces", "card_printings"
  add_foreign_key "card_printings", "card_sets"
end
