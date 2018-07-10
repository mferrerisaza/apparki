class VehiclesController < ApplicationController

  def index
    @vehicles = policy_scope(Vehicle)
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
    end
    authorize vehicle
    if amount_debt.zero? && ticket.save
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

end
