class TicketsController < ApplicationController
  before_action :set_parking_zones, only: [:new, :create]
  before_action :set_ticket, only: [:show]

  def index
    @tickets = Ticket.where(nil)
    @tickets = @tickets.search_by_plate(params[:plate]) if params[:plate].present?
    @open_tickets = policy_scope(@tickets).where(status: "pendiente").order(entry: :asc)
    beginning_of_day = Time.zone.now.beginning_of_day
    end_of_day = Time.zone.now.end_of_day
    @close_tickets = policy_scope(@tickets).where(status: "pagado").where(exit: beginning_of_day..end_of_day).order(exit: :desc)
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
      respond_to do |format|
        format.html { redirect_to tickets_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js
      end
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.exit = ticket_params[:exit]
    @ticket.update_charge
    @ticket.status = "pagado"
    authorize @ticket
    if @ticket.save
      respond_to do |format|
        flash[:notice] = "Cobro generado con éxito"
        format.html { redirect_to ticket_path(@ticket) }
        format.js
      end
    else
      flash[:alert] = "Ha ocurrido un error, porfavor inténtalo nuevamente"
      respond_to do |format|
        format.html { render 'show' }
        format.js
      end
    end
  end

  def arqueo
    @user_tickets = Ticket.user_tickets(current_user)
    authorize @user_tickets
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
