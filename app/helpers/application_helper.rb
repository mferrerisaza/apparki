module ApplicationHelper
  def parking_time(entry)
    minutos = minutes_open(entry)
    horas = hours(minutos)
    minutos_sobrantes = min_sobr(horas)
    return "Registrado hace #{minutos} minuto" if minutos == 1
    return "Registrado hace #{minutos} minutos" if minutos < 60
    return "Registrado hace #{horas.floor} hora y #{minutos_sobrantes.ceil} minutos" if horas.floor == 1
    return "Registrado hace #{horas.floor} horas y #{minutos_sobrantes.ceil} minutos"
  end

  def paid_time(entry, exit)
    minutos = minutes_closed(entry, exit)
    horas = hours(minutos)
    minutos_sobrantes = min_sobr(horas)
    return "#{minutos} minuto facturado" if minutos == 1
    return "#{minutos} minutos facturados" if minutos < 60
    return "#{horas.floor} horafacturada" if horas == 1 && minutos_sobrantes == 0
    return "#{horas.floor} hora y #{minutos_sobrantes.ceil} minutos facturados" if horas == 1
    return "#{horas.floor} horas facturadas" if minutos_sobrantes = 0
    return "#{horas.floor} horas y #{minutos_sobrantes.ceil} minutos facturados"
  end

  def money_paid(entry, exit, price)
    minutos = minutes_closed(entry, exit)
    horas = hours(minutos)
    money = horas.ceil * price
  end

  def humanize_price(money)
    humanized_money(money)
  end

  def hours_paid(entry, exit)
    minutos = minutes_closed(entry, exit)
    horas = hours(minutos)
    return "1 hora" if horas.floor < 2
    return "#{horas.floor} horas" if horas.floor > 1
  end

  def car_picture_or_generic(picture)
    options =
      {
        # aspect_ratio: "1.1",
        # crop: "pad"
      }

    if picture.blank?
      cl_image_path('Default Pics/ticketplaceholder.jpg', options)
    else
      cl_image_path(picture, options)
    end
  end

  def amount_per_user_chart_data
    ParkingZone.all.map do |pa|
      {
        zone: pa.name,
        amount: Ticket.where("parking_zone_id = ?", pa.id).sum(:charge_cents)/100
      }
    end
  end

  def subtotal_day(tickets)
    humanize_price(tickets.sum(:charge_cents)/100)
  end

  def count_day_tickets(tickets)
    tickets.size
  end

  def count_day_closed_tickets(tickets)
    tickets.select {|ticket| ticket.exit.present? && ticket.status == "pagado"}.size
  end

  def count_day_warned_tickets(tickets)
    tickets.select {|ticket| ticket.status == "reportado"}.size
  end

  def count_parked_vehicles(tickets)
    tickets.select {|ticket| ticket.status == "pendiente"}.size
  end

  private

  def minutes_open(entry)
    ((Time.now - entry)/60).ceil
  end

  def minutes_closed(entry, exit)
    ((exit - entry)/60).ceil
  end

  def hours(min)
    min/60.0
  end

  def min_sobr(hours)
    (hours - hours.floor)*60
  end

end
