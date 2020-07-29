# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_29_115335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "geometries", force: :cascade do |t|
    t.geometry "geom", limit: {:srid=>0, :type=>"geometry"}
    t.string "name", null: false
    t.text "description"
    t.string "gid", null: false
    t.integer "location_type", null: false
    t.integer "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gid"], name: "index_geometries_on_gid"
    t.index ["location_type"], name: "index_geometries_on_location_type"
    t.index ["name"], name: "index_geometries_on_name"
    t.index ["parent_id"], name: "index_geometries_on_parent_id"
  end

  create_table "indicator_data", force: :cascade do |t|
    t.integer "hazard_value"
    t.bigint "geometry_id", null: false
    t.bigint "indicator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["geometry_id"], name: "index_indicator_data_on_geometry_id"
    t.index ["indicator_id"], name: "index_indicator_data_on_indicator_id"
  end

  create_table "indicators", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_indicators_on_name"
  end

  create_table "layers", force: :cascade do |t|
    t.string "name"
    t.string "layer_type"
    t.jsonb "source"
    t.jsonb "render"
    t.json "legend_config"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_layers_on_category_id"
    t.index ["layer_type"], name: "index_layers_on_layer_type"
    t.index ["name"], name: "index_layers_on_name", unique: true
  end

  create_table "metadata", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.jsonb "source"
    t.jsonb "aditional"
    t.jsonb "links"
    t.bigint "layer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["layer_id"], name: "index_metadata_on_layer_id"
    t.index ["title"], name: "index_metadata_on_title"
  end

  create_table "widgets", force: :cascade do |t|
    t.string "name"
    t.string "widget_type"
    t.jsonb "source"
    t.jsonb "config"
    t.bigint "layer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["layer_id"], name: "index_widgets_on_layer_id"
    t.index ["name"], name: "index_widgets_on_name", unique: true
  end

  add_foreign_key "indicator_data", "geometries"
  add_foreign_key "indicator_data", "indicators"
  add_foreign_key "layers", "categories"
  add_foreign_key "metadata", "layers"
  add_foreign_key "widgets", "layers"
end
