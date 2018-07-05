class AddChargePaidToTickets < ActiveRecord::Migration[5.1]
  def change
    add_monetize :tickets, :charge_paid, currency: { present: false }
  end
end
