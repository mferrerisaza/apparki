class RenameZoneNameInParkingZones < ActiveRecord::Migration[5.1]
  def change
    rename_column :parking_zones, :zone_name, :name
  end
end
