class CropsController < ApplicationController
  before_filter :find_image

  # GET /images/:image_id/crops
  # GET /images/:image_id//crops.xml
  def index
    @crops = @image.crops.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @crops }
    end
  end

  # GET /crops/1
  # GET /crops/1.xml
  def show
    @crop = Crop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @crop }
    end
  end

  # GET /images/:image_id/crops/new
  # GET /images/:image_id/crops/new.xml
  def new
    @crop = @image.crops.build
    @crop.crop_definition = if params[:crop] && params[:crop][:crop_definition_id]
      CropDefinition.find(params[:crop][:crop_definition_id])
    else
      @image.crop_definitions.first
    end

    respond_to do |format|
      format.html # new.html.erb
      format.js   # new.js.erb
      format.xml  { render :xml => @crop }
    end
  end

  # GET /crops/1/edit
  def edit
    @crop = Crop.find(params[:id])
    # Assign selected crop definition to @crop if one is being specified
    @crop.crop_definition = CropDefinition.find(params[:crop][:crop_definition_id]) if params[:crop] && params[:crop][:crop_definition_id]

    respond_to do |format|
      format.html # edit.html.erb
      format.js   # edit.js.erb
    end
  end

  # POST /images/:image_id/crops
  # POST /images/:image_id/crops.xml
  def create
    @crop = @image.crops.build(params[:crop])

    respond_to do |format|
      if @crop.save
        flash[:notice] = 'Crop was successfully created.'
        format.html { redirect_to([@image, @crop]) }
        format.xml  { render :xml => @crop, :status => :created, :location => @crop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @crop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /crops/1
  # PUT /crops/1.xml
  def update
    @crop = Crop.find(params[:id])

    respond_to do |format|
      if @crop.update_attributes(params[:crop])
        flash[:notice] = 'Crop was successfully updated.'
        format.html { redirect_to([@image, @crop]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @crop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /crops/1
  # DELETE /crops/1.xml
  def destroy
    @crop = Crop.find(params[:id])
    @crop.destroy

    respond_to do |format|
      format.html { redirect_to([@image, :crops]) }
      format.xml  { head :ok }
    end
  end

protected
  def find_image
    @image = Image.find(params[:image_id])
  end
end