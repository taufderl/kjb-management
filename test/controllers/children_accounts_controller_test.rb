require 'test_helper'

class ChildrenAccountsControllerTest < ActionController::TestCase
  setup do
    @children_account = children_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:children_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create children_account" do
    assert_difference('ChildrenAccount.count') do
      post :create, children_account: { children_id: @children_account.children_id }
    end

    assert_redirected_to children_account_path(assigns(:children_account))
  end

  test "should show children_account" do
    get :show, id: @children_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @children_account
    assert_response :success
  end

  test "should update children_account" do
    patch :update, id: @children_account, children_account: { children_id: @children_account.children_id }
    assert_redirected_to children_account_path(assigns(:children_account))
  end

  test "should destroy children_account" do
    assert_difference('ChildrenAccount.count', -1) do
      delete :destroy, id: @children_account
    end

    assert_redirected_to children_accounts_path
  end
end
