class AddAddresToParkingZone < ActiveRecord::Migration[5.1]
  def change
    add_column :parking_zones, :address, :string
  end
end
