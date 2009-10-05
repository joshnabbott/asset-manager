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
    if params[:crop] && params[:crop][:crop_definition_id]
      @crop_definition = CropDefinition.find(params[:crop][:crop_definition_id])
    else
      @crop_definition = @image.crop_definitions.last
    end

    respond_to do |format|
      format.html # new.html.erb
      format.js do
        render(:update) do |page|
          page.replace_html 'image', :partial => 'image'
          page << <<-JS
            jQuery('#jcrop-target').Jcrop({
              aspectRatio: #{@crop_definition.locked_ratio ? (@crop_definition.minimum_width.to_f / @crop_definition.minimum_height.to_f) : 1},
              bgColor: 'white',
              bgOpacity: '.5',
              boxWidth: #{@image.width * (params[:scale] ? (params[:scale].to_f / 100) : 0.25)},
              trueSize: [#{@image.width}, #{@image.height}],
              minSize: [#{@crop_definition.minimum_width}, #{@crop_definition.minimum_height}],
              setSelect: [#{@crop_definition.x}, #{@crop_definition.y}, #{@crop_definition.x + @crop_definition.minimum_width}, #{@crop_definition.y + @crop_definition.minimum_height}],
              onChange: function(c) {
                $('#crop_offset_x').val(c.x);
                $('#crop_offset_y').val(c.y);
                $('#crop_width').val(c.w);
                $('#crop_height').val(c.h);
              }
            });
          JS
        end
      end
      format.xml  { render :xml => @crop }
    end
  end

  # GET /crops/1/edit
  def edit
    @crop = Crop.find(params[:id])

    respond_to do |format|
      format.html
      format.js do
        render(:update) do |page|
          page.replace_html 'image', :partial => 'image'
          page << <<-JS
            jQuery('#jcrop-target').Jcrop({
              aspectRatio: #{@crop.crop_definition.locked_ratio ? (@crop.crop_definition.minimum_width.to_f / @crop.crop_definition.minimum_height.to_f) : 0},
              bgColor: 'black',
              bgOpacity: '.5',
              boxWidth: #{@image.width * (params[:scale].to_f || 0.25)},
              trueSize: [#{@image.width}, #{@image.height}],
              minSize: [#{@crop.crop_definition.minimum_width}, #{@crop.crop_definition.minimum_height}],
              setSelect: [#{@crop.offset_x}, #{@crop.offset_y}, #{@crop.offset_x + @crop.width}, #{@crop.offset_y + @crop.height}],
              onChange: function(c) {
                $('#crop_offset_x').val(c.x);
                $('#crop_offset_y').val(c.y);
                $('#crop_width').val(c.w);
                $('#crop_height').val(c.h);
               }
            });
          JS
        end
      end
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