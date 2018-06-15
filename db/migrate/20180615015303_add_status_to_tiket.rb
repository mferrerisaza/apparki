class AddStatusToTiket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :status, :string
  end
end
