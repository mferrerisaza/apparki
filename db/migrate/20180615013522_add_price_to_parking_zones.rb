class AddPriceToParkingZones < ActiveRecord::Migration[5.1]
  def change
    add_monetize :parking_zones, :price, currency: { present: false }
  end
end
