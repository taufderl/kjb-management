require 'test_helper'

class ScoutsBookkeepingControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get billing" do
    get :billing
    assert_response :success
  end

  test "should get input" do
    get :input
    assert_response :success
  end

end
