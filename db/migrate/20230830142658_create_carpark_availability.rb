class CreateCarparkAvailability < ActiveRecord::Migration[7.0]
  def change
    create_table :carpark_availabilities, id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string :carpark_number, null: false
      t.string :lot_type
      t.integer :total_lots
      t.integer :lots_available, null: false

      t.timestamps

      t.index [:carpark_number], name: 'index_carparks_on_carpark_number', unique: true
    end
  end
end
