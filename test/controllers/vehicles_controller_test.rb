require 'test_helper'

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  test "should get tickets" do
    get vehicles_tickets_url
    assert_response :success
  end

  test "should get parking_zones" do
    get vehicles_parking_zones_url
    assert_response :success
  end

end
