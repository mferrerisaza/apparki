class Ticket < ApplicationRecord
  STATUS_CHOICES = %w[pagado pendiente reportado]
  belongs_to :parking_zone
  belongs_to :vehicle

  monetize :charge_cents
  mount_uploader :picture, PhotoUploader

  validates :entry, :status, presence: true
  validates :status, inclusion: { in: STATUS_CHOICES }
  validate :vehicle_tickets, on: :create

  def vehicle_tickets
    if Ticket.where(status: "pendiente").where(vehicle_id: self.vehicle.id).blank?
      true
    else
      errors.messages[:vehicle] << "este vehículo ya tiene un tiquete activo"
    end
  end

  def self.search_by_plate(query)
    joins(:vehicle).where("plate ILIKE ?", "%#{query}%")
  end

  def update_charge
    if exit.blank?
      time_parked = (Time.zone.now-entry)/1.hour
    else
      time_parked = (exit-entry)/1.hour
    end
    grace_time =  0.25
    # beginning_of_day = Time.zone.now - 3.hours
    # end_of_day = Time.zone.now
    # tickets_today = Ticket.where(vehicle: self.vehicle).where.not(status: "pendiente").where(entry: beginning_of_day..end_of_day)
    # time_frame_array = tickets_today.map { |ticket| (ticket.exit-ticket.entry)/1.hour }
    # time = time_frame_array.reduce(:+)
    # time = 0 if time.blank?
    hours =  0
    unless grace_time >= time_parked
      hours = time_parked - time_parked.floor >= 1 / 60.0 ?  time_parked.ceil : time_parked.floor
    end
    hours * parking_zone.price
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

  def self.group_tickets(period)
    date = Time.zone.today
    if period == "week"
      beg = date.beginning_of_week
      endd = date.end_of_week
    elsif period == "month"
      beg = date.beginning_of_month
      endd = date.end_of_month
    elsif period == "year"
      beg = date.beginning_of_year
      endd = date.end_of_year
    end
    group_tickets = Ticket.where(entry: beg..endd)
  end

  def self.user_tickets(user)
    Ticket.joins(:parking_zone).where(parking_zones: {user: user}).where(entry: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
