require 'test_helper'

class DisbursementsControllerTest < ActionController::TestCase
  setup do
    @disbursement = disbursements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:disbursements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create disbursement" do
    assert_difference('Disbursement.count') do
      post :create, disbursement: { accounts_id: @disbursement.accounts_id, amount: @disbursement.amount, cleared: @disbursement.cleared, date: @disbursement.date }
    end

    assert_redirected_to disbursement_path(assigns(:disbursement))
  end

  test "should show disbursement" do
    get :show, id: @disbursement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @disbursement
    assert_response :success
  end

  test "should update disbursement" do
    patch :update, id: @disbursement, disbursement: { accounts_id: @disbursement.accounts_id, amount: @disbursement.amount, cleared: @disbursement.cleared, date: @disbursement.date }
    assert_redirected_to disbursement_path(assigns(:disbursement))
  end

  test "should destroy disbursement" do
    assert_difference('Disbursement.count', -1) do
      delete :destroy, id: @disbursement
    end

    assert_redirected_to disbursements_path
  end
end
