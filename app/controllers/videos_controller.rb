class VideosController < ApplicationController
  # GET /videos
  # GET /videos.xml
  def index
    @videos = Video.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.xml
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.js # javascript for uploadify
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end
  
  # GET /videos/:ids/edit
  def edit_batches
    @videos = Video.find(params[:ids])
  end

  # POST /videos
  # POST /videos.xml
  def create
    # For uploadify (multi-upload)
    if params['Filedata']
      @video = Video.new(:uploadify_file => params['Filedata'])
      respond_to do |format|
        if @video.save
          flash[:success]  = 'Video was successfully created.'
          flash[:video_id] = @video.id
          format.html { render :text => flash.to_json, :status => 200 }
        else
          flash[:error] = 'There was an error creating the video.'
          format.html { render :text => flash[:error], :status => 500 }
        end
      end
    else
      @video = Video.new(params[:video])
      respond_to do |format|
        if @video.save
          flash[:notice] = 'Video was successfully created.'
          format.html { redirect_to(@video) }
          format.xml  { render :xml => @video, :status => :created, :location => @video }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        flash[:notice] = 'Video was successfully updated.'
        format.html { redirect_to(@video) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /videos/:ids
  def update_batches
    @videos = Video.find(params[:ids])
    @videos.each_with_index do |video, index|
      video.title = params[:video]['title'][index]
      video.description = params[:video]['description'][index]
      video.tag_list = params[:video]['tag_list'][index]
    end

    respond_to do |format|
      if @videos.map(&:save)
        flash[:notice] = 'Videos were successfully updated.'
        format.html { redirect_to(videos_path) }
      else
        format.html { render :action => "edit_batches" }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(videos_url) }
      format.xml  { head :ok }
    end
  end
  
  # DELETE /videos/:ids
  def destroy_batches
    @videos = Video.find(params[:ids])
    @videos.map(&:destroy)

    respond_to do |format|
      format.html { redirect_to(videos_url) }
      format.xml  { head :ok }
    end
  end
  
end