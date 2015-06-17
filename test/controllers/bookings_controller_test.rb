require 'test_helper'

class BookingsControllerTest < ActionController::TestCase
  setup do
    @booking = bookings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post :create, booking: { accounting_number: @booking.accounting_number, accounts_id: @booking.accounts_id, amount: @booking.amount, created_by: @booking.created_by, date: @booking.date, note1: @booking.note1, note2: @booking.note2, remarks: @booking.remarks, updated_by: @booking.updated_by }
    end

    assert_redirected_to booking_path(assigns(:booking))
  end

  test "should show booking" do
    get :show, id: @booking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @booking
    assert_response :success
  end

  test "should update booking" do
    patch :update, id: @booking, booking: { accounting_number: @booking.accounting_number, accounts_id: @booking.accounts_id, amount: @booking.amount, created_by: @booking.created_by, date: @booking.date, note1: @booking.note1, note2: @booking.note2, remarks: @booking.remarks, updated_by: @booking.updated_by }
    assert_redirected_to booking_path(assigns(:booking))
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete :destroy, id: @booking
    end

    assert_redirected_to bookings_path
  end
end
