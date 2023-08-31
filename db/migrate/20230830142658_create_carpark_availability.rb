class CreateCarparkAvailability < ActiveRecord::Migration[7.0]
  def self.up
    create_table :carpark_availabilities do |t|
      t.string :carpark_number, null: false
      t.string :lot_type
      t.integer :total_lots
      t.integer :available_lots, null: false
      t.datetime :update_datetime

      t.timestamps

      t.index [:carpark_number], name: 'index_carpark_availabilities_on_carpark_number', unique: true
    end
  end

  def self.down
    drop_table :carpark_availabilities
  end
end
