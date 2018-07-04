class AddColumReferencesToTickets < ActiveRecord::Migration[5.1]
  def change
    add_reference :tickets, :entry_user
    add_reference :tickets, :exit_user
  end
end
