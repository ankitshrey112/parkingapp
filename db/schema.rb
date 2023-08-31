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

ActiveRecord::Schema[7.0].define(version: 2023_08_30_142658) do
  create_table "carpark_availabilities", charset: "latin1", force: :cascade do |t|
    t.string "carpark_number", null: false
    t.string "lot_type"
    t.integer "total_lots"
    t.integer "available_lots", null: false
    t.datetime "update_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carpark_number"], name: "index_carpark_availabilities_on_carpark_number", unique: true
  end

  create_table "carparks", charset: "latin1", force: :cascade do |t|
    t.string "carpark_number", null: false
    t.string "address"
    t.decimal "latitude", precision: 10, scale: 4, null: false
    t.decimal "longitude", precision: 10, scale: 4, null: false
    t.string "carpark_type"
    t.string "type_of_parking_system"
    t.string "short_term_parking"
    t.string "free_parking"
    t.string "night_parking"
    t.integer "car_park_decks"
    t.decimal "gantry_height", precision: 10, scale: 4
    t.string "car_park_basement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carpark_number"], name: "index_carparks_on_carpark_number", unique: true
    t.index ["latitude"], name: "index_carparks_on_carpark_lat_long"
  end

end
