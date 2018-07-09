ActiveAdmin.register Ticket do
  permit_params :parking_zone_id, :vehicle_id, :entry_user_id, :exit_user_id, :entry, :exit, :picture, :status, :charge_cents
end
