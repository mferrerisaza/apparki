class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    @tickets = policy_scope(Ticket)
    @week_tickets = Ticket.group_tickets("week")
    @month_tickets = Ticket.group_tickets("month")
    @year_tickets = Ticket.group_tickets("year")
    @users = User.all
    @reported_tickets = Ticket.where(status: "reportado")
  end
end
