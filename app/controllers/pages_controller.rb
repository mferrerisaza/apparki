class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def report
    @tickets = policy_scope(Ticket)
  end
end
