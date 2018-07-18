require 'test_helper'

class ParkingZonesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parking_zones_index_url
    assert_response :success
  end

  test "should get show" do
    get parking_zones_show_url
    assert_response :success
  end

  test "should get landing" do
    get parking_zones_landing_url
    assert_response :success
  end

end
