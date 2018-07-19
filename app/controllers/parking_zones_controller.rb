class ParkingZonesController < ApplicationController
  skip_after_action :verify_authorized, only: :landing
  before_action :set_parking_zone, only: [:show]

  def landing
  end

  def index
    @parking_zones = policy_scope(ParkingZone.all)
    @parking_zones = @parking_zones.where(vehicle_type: params[:vehicle_type])
  end

  def show
    authorize @parking_zone
  end

  private

  def parking_zone_params
    params.require(:parking_zone).permit(:vehicle_type)
  end

  def set_parking_zone
    @parking_zone = ParkingZone.find(params[:id])
  end
end
