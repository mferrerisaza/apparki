class VehiclesController < ApplicationController

  def index
    @vehicles = policy_scope(Vehicle)
  end

  def new

  end

  def create

  end

  def update
    vehicle = Vehicle.find(params[:id])
    ticket = Ticket.find(vehicle_params[:ticket_ids])
    ticket.exit = Time.zone.now
    vehicle.debt = ticket.update_charge
    ticket.status = "reportado"
    authorize vehicle
    if vehicle.save && ticket.save
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
