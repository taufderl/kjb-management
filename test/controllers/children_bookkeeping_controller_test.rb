require 'test_helper'

class ChildrenBookkeepingControllerTest < ActionController::TestCase
  test "should get payment" do
    get :payment
    assert_response :success
  end

  test "should get new_payment" do
    get :new_payment
    assert_response :success
  end

end
