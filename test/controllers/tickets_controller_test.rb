require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tickets_index_url
    assert_response :success
  end

  test "should get new" do
    get tickets_new_url
    assert_response :success
  end

  test "should get edit" do
    get tickets_edit_url
    assert_response :success
  end

end
