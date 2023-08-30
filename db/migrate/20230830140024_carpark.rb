class Carpark < ActiveRecord::Migration[7.0]
  def change
    create_table :carparks, id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string :carpark_number
      t.float :latitude
      t.float :longitude
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
      t.index [:latitude, :latitude], name: 'index_carparks_on_carpark_number'
    end
  end
end
