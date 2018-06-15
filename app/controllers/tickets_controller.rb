class TicketsController < ApplicationController
  before_action :set_parking_zones, only: [:new, :create]
  def index
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @vehicle = Vehicle.find_by(plate: vehicle_params[:plate].upcase)
    @vehicle = Vehicle.create(plate: vehicle_params[:plate].upcase) if @vehicle.blank?
    @vehicle = nil unless @vehicle.valid?
    @ticket = Ticket.new(ticket_params)
    @ticket.vehicle = @vehicle unless @vehicle.nil?
    if @ticket.save
      redirect_to tickets_path
    else
      render 'new'
    end
  end

  private

  def set_parking_zones
    @parking_zones = ParkingZone.where(user: current_user)
  end

  def ticket_params
    params.require(:ticket).permit(:entry, :parking_zone_id, :picture, :picture_cache, :status)
  end
  def vehicle_params
    params.require(:vehicle).permit(:plate)
  end
end
