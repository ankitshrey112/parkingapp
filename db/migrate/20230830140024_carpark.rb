class Carpark < ActiveRecord::Migration[7.0]
  def self.up
    create_table :carparks do |t|
      t.string :carpark_number, null: false
      t.string :address
      t.decimal :latitude, null: false, precision: 10, scale: 6
      t.decimal :longitude, null: false, precision: 10, scale: 6
      t.string :carpark_type
      t.string :type_of_parking_system
      t.string :short_term_parking
      t.string :free_parking
      t.string :night_parking
      t.integer :car_park_decks
      t.decimal :gantry_height, precision: 10, scale: 4
      t.string :car_park_basement
      t.string :status

      t.timestamps

      t.index [:carpark_number], name: 'index_carparks_on_carpark_number', unique: true
      t.index [:latitude, :latitude, :status], name: 'index_carparks_on_carpark_lat_long'
    end

    execute "ALTER TABLE carparks ADD CONSTRAINT status_check CHECK (status IN ('active', 'inactive'))"
  end

  def self.down
    drop_table :carparks
  end
end
