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
  create_table "carpark_availabilities", id: { type: :binary, limit: 16 }, charset: "latin1", force: :cascade do |t|
    t.binary "carpark_id", limit: 16, null: false
    t.string "lot_type"
    t.integer "total_lots"
    t.integer "lots_available", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carpark_id"], name: "index_carparks_on_carpark_number", unique: true
  end

end
