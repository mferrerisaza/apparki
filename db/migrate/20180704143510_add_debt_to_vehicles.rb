class AddDebtToVehicles < ActiveRecord::Migration[5.1]
  def change
    add_monetize :vehicles, :debt, currency: { present: false }
  end
end
