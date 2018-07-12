class VehiclesController < ApplicationController
  before_action :set_vehicle, only: :show

  def index
    @vehicles = policy_scope(Vehicle)
  end

  def show
    authorize @vehicle
  end

  def update
    vehicle = Vehicle.find(params[:id])
    ticket = Ticket.find(vehicle_params[:ticket_ids])
    ticket.exit = Time.zone.now
    amount_debt = ticket.update_charge
    vehicle.debt += amount_debt
    ticket.charge = amount_debt
    if amount_debt.zero?
      ticket.status = "pagado"
      ticket.exit_user = current_user
    else
      ticket.status = "reportado"
      ticket.exit_user = current_user
    end
    authorize vehicle
    if amount_debt.zero? && ticket.charge_paid_cents > 0 &&  ticket.save
      flash[:notice] = "El vehículo ya ha pagado el periodo a cobrar"
      redirect_to ticket_path(ticket)
    elsif amount_debt.zero? && ticket.save
      flash[:notice] = "El vehículo no ha superado el límite de tiempo gratis"
      redirect_to ticket_path(ticket)
    elsif vehicle.save && ticket.save
      flash[:notice] = "Vehículo repotado con éxito"
      redirect_to ticket_path(ticket)
    else
      flash[:alert] = "Ha ocurrido un error, porfavor inténtalo nuevamente"
      render 'tickets/show'
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:ticket_ids)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
    @tickets = Ticket.where(nil)
    @tickets = @tickets.where(vehicle: @vehicle)
    @open_tickets = @tickets.where(status: "pendiente").order(entry: :asc)
    @close_tickets = @tickets.where(status: "pagado").order(exit: :desc)
    @reported_tickets = @tickets.where(status: "reportado").order(exit: :desc)
  end

end
