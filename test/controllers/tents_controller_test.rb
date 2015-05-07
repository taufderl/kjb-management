require 'test_helper'

class TentsControllerTest < ActionController::TestCase
  setup do
    @tent = tents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tent" do
    assert_difference('Tent.count') do
      post :create, tent: { number: @tent.number }
    end

    assert_redirected_to tent_path(assigns(:tent))
  end

  test "should show tent" do
    get :show, id: @tent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tent
    assert_response :success
  end

  test "should update tent" do
    patch :update, id: @tent, tent: { number: @tent.number }
    assert_redirected_to tent_path(assigns(:tent))
  end

  test "should destroy tent" do
    assert_difference('Tent.count', -1) do
      delete :destroy, id: @tent
    end

    assert_redirected_to tents_path
  end
end
