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
    grace_time = time_parked.floor + 0.25
    hours = grace_time >= time_parked ? time_parked.floor : time_parked.ceil
    self.charge = hours * parking_zone.price
  end
end
