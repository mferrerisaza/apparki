class DayClosingJob < ApplicationJob
  queue_as :default

  def perform(ticket_id)
    ticket = Ticket.find(ticket_id)
    vehicle = ticket.vehicle
    ticket.exit = Time.zone.now.change(hour: 20)
    amount_debt = ticket.update_charge
    vehicle.debt += amount_debt
    ticket.charge = amount_debt
    amount_debt.zero? ? ticket.status = "pagado" : ticket.status = "reportado"
    if amount_debt.zero? && ticket.save
      puts "El vehículo no ha superado el límite de tiempo gratis"
    elsif vehicle.save && ticket.save
      puts "Vehículo repotado con éxito"
    else
      puts "Ha ocurrido un error en el ticket #{ticket.id} o el vehiculo #{vehicle.id}, porfavor inténtalo nuevamente"
    end
  end
end
