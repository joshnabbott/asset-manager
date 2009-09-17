# TODO: Clean up update_batches method
class ImagesController < ApplicationController
  # GET /images
  # GET /images.xml
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @images }
    end
  end

  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # GET /images/:ids/edit
  def edit_batches
    @images = Image.find(params[:ids])
  end

  # POST /images
  # POST /images.xml
  def create
    # For uploadify (multi-upload)
    if params['Filedata']
      @image = Image.new(:uploadify_file => params['Filedata'])
      respond_to do |format|
        if @image.save
          flash[:success]  = 'Image was successfully created.'
          flash[:image_id] = @image.id
          format.html { render :text => flash.to_json, :status => 200 }
        else
          flash[:error] = 'There was an error creating the image.'
          format.html { render :text => flash[:error], :status => 500 }
        end
      end
    else
      # For normal upload
      @image = Image.new(params[:image])

      respond_to do |format|
        if @image.save
          flash[:notice] = 'Image was successfully created.'
          format.html { redirect_to(@image) }
          format.xml  { render :xml => @image, :status => :created, :location => @image }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:notice] = 'Image was successfully updated.'
        format.html { redirect_to(@image) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /images/:ids
  def update_batches
    @images = Image.find(params[:ids])
    @images.each_with_index do |image, index|
      image.title       = params[:image]['title'][index]
      image.description = params[:image]['description'][index]
      image.tag_list    = params[:image]['tag_list'][index]
    end

    respond_to do |format|
      if @images.map(&:save)
        flash[:notice] = 'Images were successfully updated.'
        format.html { redirect_to(images_path) }
      else
        format.html { render :action => "edit_batches" }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end

protected
  def last_uploaded_ids
    cookies[:last_uploaded_ids] ||= { :value => [] }
  end
end