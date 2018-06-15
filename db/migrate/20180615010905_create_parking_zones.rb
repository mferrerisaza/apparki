class CreateParkingZones < ActiveRecord::Migration[5.1]
  def change
    create_table :parking_zones do |t|
      t.string :zone_name
      t.string :city
      t.integer :price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
