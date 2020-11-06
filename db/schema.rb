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

ActiveRecord::Schema.define(version: 2020_11_06_111033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

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
    t.integer "state_fp"
    t.integer "county_fp"
    t.jsonb "geojson"
    t.jsonb "properties"
    t.jsonb "bbox"
    t.integer "tract_ce"
    t.index ["county_fp"], name: "index_geometries_on_county_fp"
    t.index ["gid"], name: "index_geometries_on_gid"
    t.index ["location_type"], name: "index_geometries_on_location_type"
    t.index ["name"], name: "index_geometries_on_name"
    t.index ["parent_id"], name: "index_geometries_on_parent_id"
    t.index ["state_fp"], name: "index_geometries_on_state_fp"
  end

  create_table "indicator_data", force: :cascade do |t|
    t.integer "hazard_value"
    t.bigint "geometry_id", null: false
    t.bigint "indicator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "absolute_value"
    t.float "normalized_value"
    t.string "range"
    t.index ["geometry_id"], name: "index_indicator_data_on_geometry_id"
    t.index ["indicator_id"], name: "index_indicator_data_on_indicator_id"
  end

  create_table "indicators", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.bigint "category_id"
    t.boolean "relevant", default: false
    t.string "labels", default: [], array: true
    t.string "legend_states", default: [], array: true
    t.string "legend_countries", default: [], array: true
    t.string "legend_title"
    t.integer "external_id"
    t.bigint "parent_id"
    t.string "legend_tracts", default: [], array: true
    t.index ["category_id"], name: "index_indicators_on_category_id"
    t.index ["labels"], name: "index_indicators_on_labels"
    t.index ["name"], name: "index_indicators_on_name"
    t.index ["parent_id"], name: "index_indicators_on_parent_id"
    t.index ["relevant"], name: "index_indicators_on_relevant"
    t.index ["slug"], name: "index_indicators_on_slug"
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
  add_foreign_key "indicators", "indicators", column: "parent_id"
  add_foreign_key "layers", "categories"
  add_foreign_key "metadata", "layers"
  add_foreign_key "widgets", "layers"
end
