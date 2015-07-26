class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :update, :destroy]

  # GET /children
  # GET /children.json
  def index
    @children = Child.all
  end

  # GET /children/1
  # GET /children/1.json
  def show
  end

  # GET /children/new
  def new
    @child = Child.new
  end

  def identify_number
    @children = Child.all
    @children_sort = @children.sort_by{|a| a[:tent]}
  end
  
  def identify_new
    @children = Child.all
    @children_sort = @children.sort_by{|a| a[:tent]}
    i=1    
    
    @children_sort.each do |n|
      n.update('number' => i)
      i = i+1
    end
    
    respond_to do |format|
      format.html{ redirect_to children_identify_number_path, notice: 'Successful.'} 
    end 
    

  end

  # GET /children/1/edit
  def edit
  end

  # POST /children
  # POST /children.json
  def create
    @child = Child.new(child_params)

    respond_to do |format|
      if @child.save
        format.html { redirect_to @child, notice: 'Child was successfully created.' }
        format.json { render :show, status: :created, location: @child }
      else
        format.html { render :new }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /children/1
  # PATCH/PUT /children/1.json
  def update
    c_params = child_params
    if c_params[:image]
      content_type = c_params[:image].content_type
      c_params[:image] = "data:"+content_type +";base64,"+Base64.encode64(c_params[:image].read)
    end
    
    respond_to do |format|
      if @child.update(c_params)
        format.html { redirect_to @child, notice: 'Child was successfully updated.' + @img.to_s }
        format.json { render :show, status: :ok, location: @child }
      else
        format.html { render :edit }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /children/1
  # DELETE /children/1.json
  def destroy
    @child.destroy
    respond_to do |format|
      format.html { redirect_to children_url, notice: 'Child was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_child
      @child = Child.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def child_params
      params.require(:child).permit(:first_name, :last_name, :birthday, :tent_id, :image, :number)
    end
end
