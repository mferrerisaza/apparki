class VehiclesController < ApplicationController

  def index
    @vehicles = policy_scope(Vehicle)
  end

  def new

  end

  def create

  end
end
