class AudiosController < ApplicationController
  # GET /audios
  # GET /audios.xml
  def index
    @audios = Audio.paginate :page => params[:page], :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @audios }
    end
  end

  # GET /audios/1
  # GET /audios/1.xml
  def show
    @audio = Audio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @audio }
    end
  end

  # GET /audios/new
  # GET /audios/new.xml
  def new
    @audio = Audio.new

    respond_to do |format|
      format.html # new.html.erb
      format.js # javascript for uploadify
      format.xml  { render :xml => @audio }
    end
  end

  # GET /audios/1/edit
  def edit
    @audio = Audio.find(params[:id])
  end
  
  # GET /audios/:ids/edit
  def edit_batches
    @audios = Audio.find(params[:ids])
  end

  # POST /audios
  # POST /audios.xml
  def create
    # For uploadify (multi-upload)
    if params['Filedata']
      @audio = Audio.new(:uploadify_file => params['Filedata'])
      respond_to do |format|
        if @audio.save
          flash[:success]  = 'Audio was successfully created.'
          flash[:audio_id] = @audio.id
          format.html { render :text => flash.to_json, :status => 200 }
        else
          flash[:error] = 'There was an error creating the audio.'
          format.html { render :text => flash[:error], :status => 500 }
        end
      end
    else
      @audio = Audio.new(params[:audio])
      respond_to do |format|
        if @audio.save
          flash[:notice] = 'Audio was successfully created.'
          format.html { redirect_to(@audio) }
          format.xml  { render :xml => @audio, :status => :created, :location => @audio }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @audio.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /audios/1
  # PUT /audios/1.xml
  def update
    @audio = Audio.find(params[:id])

    respond_to do |format|
      if @audio.update_attributes(params[:audio])
        flash[:notice] = 'Audio was successfully updated.'
        format.html { redirect_to(@audio) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @audio.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /audios/:ids
  def update_batches
    @audios = Audio.find(params[:ids])
    @audios.each_with_index do |audio, index|
      audio.title = params[:audio]['title'][index]
      audio.description = params[:audio]['description'][index]
      audio.tag_list = params[:audio]['tag_list'][index]
    end

    respond_to do |format|
      if @audios.map(&:save)
        flash[:notice] = 'Audios were successfully updated.'
        format.html { redirect_to(audios_path) }
      else
        format.html { render :action => "edit_batches" }
      end
    end
  end

  # DELETE /audios/1
  # DELETE /audios/1.xml
  def destroy
    @audio = Audio.find(params[:id])
    @audio.destroy

    respond_to do |format|
      format.html { redirect_to(audios_url) }
      format.xml  { head :ok }
    end
  end
  
  # DELETE /audios/:ids
  def destroy_batches
    @audios = Audio.destroy(params[:ids])

    respond_to do |format|
      format.html { redirect_to(audios_url) }
      format.xml  { head :ok }
    end
  end
  
end
