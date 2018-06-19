class AddChargeToTicket < ActiveRecord::Migration[5.1]
  def change
    add_monetize :tickets, :charge, currency: { present: false }
  end
end
