class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.datetime :entry
      t.datetime :exit
      t.string :picture
      t.references :parking_zone, foreign_key: true
      t.references :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
