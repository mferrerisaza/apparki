class AddVehicleTypeToParkingZone < ActiveRecord::Migration[5.1]
  def change
    add_column :parking_zones, :vehicle_type, :string
  end
end
