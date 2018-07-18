class ParkingZonePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def landing?
    true
  end

  def show?
    true
  end

end
