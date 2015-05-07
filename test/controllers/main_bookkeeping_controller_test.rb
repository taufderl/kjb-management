require 'test_helper'

class MainBookkeepingControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get billing" do
    get :billing
    assert_response :success
  end

end
