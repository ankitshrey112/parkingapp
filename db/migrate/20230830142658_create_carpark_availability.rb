class CreateCarparkAvailability < ActiveRecord::Migration[7.0]
  def self.up
    create_table :carpark_availabilities do |t|
      t.string :carpark_number, null: false
      t.string :lot_type
      t.integer :total_lots
      t.integer :available_lots, null: false
      t.datetime :update_datetime
      t.string :status

      t.timestamps

      t.index [:carpark_number], name: 'index_carpark_availabilities_on_carpark_number', unique: true
      t.index [:available_lots, :status], name: 'index_carpark_availabilities_on_available_lots_status'
    end

    add_foreign_key :carpark_availabilities, :carparks, column: :carpark_number, primary_key: :carpark_number

    execute "ALTER TABLE carpark_availabilities ADD CONSTRAINT status_check CHECK (status IN ('active', 'inactive'))"
  end

  def self.down
    drop_table :carpark_availabilities
  end
end
