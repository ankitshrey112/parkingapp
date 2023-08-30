class CreateCarparkAvailability < ActiveRecord::Migration[7.0]
  def change
    create_table :carpark_availabilities, id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string :carpark_number
      t.string :lot_type
      t.integer :total_lots
      t.integer :lots_available

      t.timestamps
    end
  end
end
