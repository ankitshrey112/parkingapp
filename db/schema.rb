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
  create_table "carparks", id: { type: :binary, limit: 16 }, charset: "latin1", force: :cascade do |t|
    t.string "carpark_number", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "carpark_type"
    t.string "type_of_parking_system"
    t.string "short_term_parking"
    t.string "free_parking"
    t.string "night_parking"
    t.integer "car_park_decks"
    t.float "gantry_height"
    t.string "car_park_basement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carpark_number"], name: "index_carparks_on_carpark_number", unique: true
    t.index ["latitude"], name: "index_carparks_on_carpark_lat_long"
  end

end
