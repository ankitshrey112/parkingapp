class Carpark < ActiveRecord::Migration[7.0]
  def self.up
    create_table :carparks do |t|
      t.string :carpark_number, null: false
      t.string :address
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :carpark_type
      t.string :type_of_parking_system
      t.string :short_term_parking
      t.string :free_parking
      t.string :night_parking
      t.integer :car_park_decks
      t.float :gantry_height
      t.string :car_park_basement

      t.timestamps

      t.index [:carpark_number], name: 'index_carparks_on_carpark_number', unique: true
      t.index [:latitude, :latitude], name: 'index_carparks_on_carpark_lat_long'
    end
  end

  def self.down
    drop_table :carparks
  end
end
