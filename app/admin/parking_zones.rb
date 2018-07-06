ActiveAdmin.register ParkingZone do
  permit_params :user_id, :name, :city, :price_cents
end
