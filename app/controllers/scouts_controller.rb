class ScoutsController < ApplicationController
  before_action :set_scout, only: [:show, :edit, :update, :destroy, :export]

  # GET /scouts
  # GET /scouts.json
  def index
    @scouts = Scout.all
  end

  # GET /scouts/1
  # GET /scouts/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.pdf {
                render pdf: "#{@scout.full_name.parameterize.underscore}" , 
                template: "scouts/show.pdf.haml",
                disposition: "inline"
      }
    end
  end

  # GET /scouts/new
  def new
    @scout = Scout.new
  end

  # GET /scouts/1/edit
  def edit
  end

  def export
    session[:notice] = @scout.to_json
    html = render_to_string(action: :show, layout: 'pdf.haml')
    pdf = WickedPdf.new.pdf_from_string(html)
        
    send_data pdf, filename: "#{@scout.full_name.parameterize.underscore}-#{Time.now.strftime("%Y-%m-%d_%H-%M-%S")}.pdf"
  end


  # POST /scouts
  # POST /scouts.json
  def create
    @scout = Scout.new(scout_params)

    respond_to do |format|
      if @scout.save
        format.html { redirect_to @scout, notice: 'Scout was successfully created.' }
        format.json { render :show, status: :created, location: @scout }
      else
        format.html { render :new }
        format.json { render json: @scout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scouts/1
  # PATCH/PUT /scouts/1.json
  def update
    respond_to do |format|
      if @scout.update(scout_params)
        format.html { redirect_to @scout, notice: 'Scout was successfully updated.' }
        format.json { render :show, status: :ok, location: @scout }
      else
        format.html { render :edit }
        format.json { render json: @scout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scouts/1
  # DELETE /scouts/1.json
  def destroy
    @scout.destroy
    respond_to do |format|
      format.html { redirect_to scouts_url, notice: 'Scout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scout
      @scout = Scout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scout_params
      params.require(:scout).permit(:first_name, :last_name, :birthday, :tent_id)
    end
end
