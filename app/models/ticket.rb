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

  def self.build_data(args = {})
    dates_array = []
    date_range = (Time.zone.today - 30.days..Time.zone.today)
    date_range.each do |date|
      beginning_of_day = date.beginning_of_day
      end_of_day = date.end_of_day
      zone_hash = {}
      ParkingZone.all.each do |pz|
        ticket_hash = {}
        tickets = Ticket.where(parking_zone: pz).where(entry: beginning_of_day..end_of_day)
        tickets.each do |ticket|
          ticket_hash[ticket.id] = ticket.charge_cents
        end
        zone_hash[pz.name] = ticket_hash
      end
    dates_array[date] = zone_hash
    end
    dates_array.each_key do |date_key|
      dates_array[date_key].each_key do |zone_key|
        dates_array[date_key][zone_key].keep_if { |_k, v| v.present? }
      end
      dates_array[date_key].keep_if { |_k, v| v.present? }
    end
  end
end
