class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create  
    bparams = booking_params
    bparams[:created_by] = User.find_by_name(session[:user])
    bparams[:date] = Date.strptime(session[:date], "%d.%m.%Y")
    
    bparams[:accounting_number] = Booking.where(account_id: bparams[:account_id]).map {|b| b.accounting_number}.compact.max.to_i+1
      
    @booking = Booking.new(bparams)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to :back, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # post /bookings/create_payment
  def create_payment
    pp = params[:booking]
    bparams = {}
    bparams[:created_by] = User.find_by_name(session[:user])
    bparams[:date] = Date.strptime(session[:date], "%d.%m.%Y")
    if pp[:payment_type] == 'in'
      bparams[:amount] = pp[:amount]
    elsif pp[:payment_type] == 'out'
      bparams[:amount]= -pp[:amount]
    end
    bparams[:remarks] = pp[:remarks]
    if pp.include? :scout_id
      # this is a scout payment
      account_id = pp[:account_id]
      accounting_number = Booking.where(account_id: account_id).map {|b| b.accounting_number}.compact.max.to_i+1
      @account_booking = Booking.new(bparams.merge(account_id: account_id, accounting_number: accounting_number))
      
      account_id = Scout.find(pp[:scout_id]).account.account.id
      @scout_booking = Booking.new(bparams.merge(account_id: account_id, accounting_number: accounting_number))
    
        @account_booking.save
      if @account_booking.valid? and @scout_booking.valid?
        @scout_booking.save
        redirect_to :back, notice: "Payment was successfully created." + "#{@account_id}"
      else
        redirect_to :back, error: "Could not save the payment due to an error."
      end
    elsif pp.include? :child_id
      # this is a child payment
      account_id = pp[:account_id]
      accounting_number = Booking.where(account_id: account_id).map {|b| b.accounting_number}.compact.max.to_i+1
      @account_booking = Booking.new(bparams.merge(account_id: account_id, accounting_number: accounting_number))
      
      account_id = Child.find(pp[:child_id]).account.account.id
      @scout_booking = Booking.new(bparams.merge(account_id: account_id, accounting_number: accounting_number))
    
        @account_booking.save
      if @account_booking.valid? and @scout_booking.valid?
        @scout_booking.save
        redirect_to :back, notice: "Payment was successfully created."
      else
        redirect_to :back, error: "Could not save the payment due to an error."
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:date, :account_id, :amount, :note1, :note2, :remarks, :created_by_id, :updated_by_id, :accounting_number)
    end
end
