class VideoFormatsController < ApplicationController
  # GET /video_formats
  # GET /video_formats.xml
  def index
    @video_formats = VideoFormat.paginate :page => params[:page], :order => 'title ASC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @video_formats }
    end
  end

  # GET /video_formats/1
  # GET /video_formats/1.xml
  def show
    @video_format = VideoFormat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @video_format }
    end
  end

  # GET /video_formats/new
  # GET /video_formats/new.xml
  def new
    @video_format = VideoFormat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video_format }
    end
  end

  # GET /video_formats/1/edit
  def edit
    @video_format = VideoFormat.find(params[:id])
  end

  # POST /video_formats
  # POST /video_formats.xml
  def create
    @video_format = VideoFormat.new(params[:video_format])

    respond_to do |format|
      if @video_format.save
        flash[:notice] = 'VideoFormat was successfully created.'
        format.html { redirect_to(@video_format) }
        format.xml  { render :xml => @video_format, :status => :created, :location => @video_format }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video_format.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /video_formats/1
  # PUT /video_formats/1.xml
  def update
    @video_format = VideoFormat.find(params[:id])

    respond_to do |format|
      if @video_format.update_attributes(params[:video_format])
        flash[:notice] = 'VideoFormat was successfully updated.'
        format.html { redirect_to(@video_format) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video_format.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /video_formats/1
  # DELETE /video_formats/1.xml
  def destroy
    @video_format = VideoFormat.find(params[:id])
    @video_format.destroy

    respond_to do |format|
      format.html { redirect_to(video_formats_url) }
      format.xml  { head :ok }
    end
  end
end
