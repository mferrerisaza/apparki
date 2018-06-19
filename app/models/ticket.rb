class Ticket < ApplicationRecord
  STATUS_CHOICES = %w[pagado pendiente reportado]
  belongs_to :parking_zone
  belongs_to :vehicle

  monetize :charge_cents
  mount_uploader :picture, PhotoUploader

  validates :entry, :status, presence: true
  validates :status, inclusion: { in: STATUS_CHOICES }

  def self.search_by_plate(query)
    joins(:vehicle).where("plate ILIKE ?", "%#{query}%")
  end

  def update_charge
    time_parked = (exit-entry)/1.hour
    grace_time =  0.25
    beginning_of_day = Time.zone.now.beginning_of_day
    end_of_day = Time.zone.now.end_of_day
    tickets_today = Ticket.where(vehicle: self.vehicle).where.not(status: "pendiente").where(entry: beginning_of_day..end_of_day).size
    hours =  0
    hours = time_parked.ceil unless tickets_today.zero? && grace_time >= time_parked
    hours = grace_time >= time_parked ? time_parked.floor : time_parked.ceil
    self.charge = hours * parking_zone.price
  end
end
