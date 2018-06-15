class DeletePriceToParkingZones < ActiveRecord::Migration[5.1]
  def change
    remove_column :parking_zones, :price
  end
end
