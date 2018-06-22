class TicketsController < ApplicationController
  before_action :set_parking_zones, only: [:new, :create]
  before_action :set_ticket, only: [:show]

  def index
    @tickets = Ticket.where(nil)
    @tickets = @tickets.search_by_plate(params[:plate]) if params[:plate].present?
    @open_tickets = policy_scope(@tickets).where(status: "pendiente")
    today = Time.now.strftime("%Y%m%d")
    @close_tickets = policy_scope(@tickets).where(status: "pagado").select{ |t| t.entry.strftime("%Y%m%d") == today}
  end

  def show
    authorize @ticket
  end

  def new
    @ticket = Ticket.new
    authorize @ticket
  end

  def create
    @vehicle = Vehicle.find_by(plate: vehicle_params[:plate].upcase)
    @vehicle = Vehicle.create(plate: vehicle_params[:plate].upcase) if @vehicle.blank?
    @vehicle = nil unless @vehicle.valid?
    @ticket = Ticket.new(ticket_params)
    @ticket.vehicle = @vehicle unless @vehicle.nil?
    authorize @ticket
    if @ticket.save
      redirect_to tickets_path
    else
      render 'new'
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.exit = ticket_params[:exit]
    @ticket.update_charge
    @ticket.status = "pagado"
    authorize @ticket
    if @ticket.save
      redirect_to ticket_path(@ticket)
    else
      flash[:alert] = "Ha ocurrido un error, porfavor inténtalo nuevamente"
      render 'show'
    end
  end

  def report_data
    @data = Ticket.build_data
    render json: @data
  end

  private

  def set_parking_zones
    @parking_zones = ParkingZone.where(user: current_user)
  end

  def ticket_params
    params.require(:ticket).permit(:entry, :exit, :parking_zone_id, :picture, :picture_cache, :status)
  end

  def vehicle_params
    params.require(:vehicle).permit(:plate)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
