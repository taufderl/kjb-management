require 'test_helper'

class ScoutsAccountsControllerTest < ActionController::TestCase
  setup do
    @scouts_account = scouts_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scouts_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scouts_account" do
    assert_difference('ScoutsAccount.count') do
      post :create, scouts_account: { scouts_id: @scouts_account.scouts_id }
    end

    assert_redirected_to scouts_account_path(assigns(:scouts_account))
  end

  test "should show scouts_account" do
    get :show, id: @scouts_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scouts_account
    assert_response :success
  end

  test "should update scouts_account" do
    patch :update, id: @scouts_account, scouts_account: { scouts_id: @scouts_account.scouts_id }
    assert_redirected_to scouts_account_path(assigns(:scouts_account))
  end

  test "should destroy scouts_account" do
    assert_difference('ScoutsAccount.count', -1) do
      delete :destroy, id: @scouts_account
    end

    assert_redirected_to scouts_accounts_path
  end
end
