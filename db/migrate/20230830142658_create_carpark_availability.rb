class CreateCarparkAvailability < ActiveRecord::Migration[7.0]
  def self.up
    create_table :carpark_availabilities do |t|
      t.integer :carpark_id, null: false
      t.string :lot_type
      t.integer :total_lots
      t.integer :lots_available, null: false

      t.timestamps

      t.index [:carpark_id], name: 'index_carparks_on_carpark_number', unique: true
    end
  end

  def self.down
    drop_table :carpark_availabilities
  end
end
