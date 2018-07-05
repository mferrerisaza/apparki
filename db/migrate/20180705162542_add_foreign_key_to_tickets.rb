class AddForeignKeyToTickets < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :tickets, :users, column: :entry_user_id, primary_key: :id
    add_foreign_key :tickets, :users, column: :exit_user_id, primary_key: :id
  end
end
