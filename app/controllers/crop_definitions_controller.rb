class CropDefinitionsController < ApplicationController
  # GET /crop_definitions
  # GET /crop_definitions.xml
  def index
    @crop_definitions = CropDefinition.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @crop_definitions }
    end
  end

  # GET /crop_definitions/1
  # GET /crop_definitions/1.xml
  def show
    @crop_definition = CropDefinition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @crop_definition }
    end
  end

  # GET /crop_definitions/new
  # GET /crop_definitions/new.xml
  def new
    @crop_definition = CropDefinition.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @crop_definition }
    end
  end

  # GET /crop_definitions/1/edit
  def edit
    @crop_definition = CropDefinition.find(params[:id])
  end

  # POST /crop_definitions
  # POST /crop_definitions.xml
  def create
    @crop_definition = CropDefinition.new(params[:crop_definition])

    respond_to do |format|
      if @crop_definition.save
        flash[:notice] = 'CropDefinition was successfully created.'
        format.html { redirect_to(@crop_definition) }
        format.xml  { render :xml => @crop_definition, :status => :created, :location => @crop_definition }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @crop_definition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /crop_definitions/1
  # PUT /crop_definitions/1.xml
  def update
    @crop_definition = CropDefinition.find(params[:id])

    respond_to do |format|
      if @crop_definition.update_attributes(params[:crop_definition])
        flash[:notice] = 'CropDefinition was successfully updated.'
        format.html { redirect_to(@crop_definition) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @crop_definition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /crop_definitions/1
  # DELETE /crop_definitions/1.xml
  def destroy
    @crop_definition = CropDefinition.find(params[:id])
    @crop_definition.destroy

    respond_to do |format|
      format.html { redirect_to(crop_definitions_url) }
      format.xml  { head :ok }
    end
  end
end
