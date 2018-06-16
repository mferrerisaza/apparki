class TicketsController < ApplicationController
  def index
    @tickets = policy_scope(Ticket)
  end

  def new
  end

  def edit
  end
end
