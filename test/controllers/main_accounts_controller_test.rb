require 'test_helper'

class MainAccountsControllerTest < ActionController::TestCase
  setup do
    @main_account = main_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:main_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create main_account" do
    assert_difference('MainAccount.count') do
      post :create, main_account: {  }
    end

    assert_redirected_to main_account_path(assigns(:main_account))
  end

  test "should show main_account" do
    get :show, id: @main_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @main_account
    assert_response :success
  end

  test "should update main_account" do
    patch :update, id: @main_account, main_account: {  }
    assert_redirected_to main_account_path(assigns(:main_account))
  end

  test "should destroy main_account" do
    assert_difference('MainAccount.count', -1) do
      delete :destroy, id: @main_account
    end

    assert_redirected_to main_accounts_path
  end
end
