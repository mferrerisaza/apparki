class Vehicle < ApplicationRecord
  has_many :tickets

  validates :plate, presence: true
  validates :plate, uniqueness: true

  monetize :debt_cents

  col_plate_regex = /([A-Z]{3}\d{3})|([A-Z]{2}\d{4})|([A-Z]{1}\d{4})|([A-Z]{3}\d{2}[A-Z])/
  validates :plate, format: { with: col_plate_regex }

  def debt?
    !debt.zero?
  end

  def clean_debt(current_user)
    tickets =  Ticket.where(vehicle: self).where(status: "reportado")
    tickets.each { |ticket| ticket.update(status: "pagado", exit_user: current_user) }
    self.update(debt: 0)
  end

  def name
    "#{id} - #{plate}"
  end
end
