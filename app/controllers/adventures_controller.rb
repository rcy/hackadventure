class AdventuresController < ApplicationController
  # GET /adventures
  # GET /adventures.xml
  def index
    @adventures = Adventure.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adventures }
    end
  end

  # GET /adventures/1
  # GET /adventures/1.xml
  def show
    @adventure = Adventure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @adventure }
    end
  end

  # GET /adventures/new
  # GET /adventures/new.xml
  def new
    @adventure = Adventure.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @adventure }
    end
  end

  # GET /adventures/1/edit
  def edit
    @adventure = Adventure.find(params[:id])
  end

  # POST /adventures
  # POST /adventures.xml
  def create
    @adventure = Adventure.new(params[:adventure])

    respond_to do |format|
      if @adventure.save
        format.html { redirect_to(@adventure, :notice => 'Adventure was successfully created.') }
        format.xml  { render :xml => @adventure, :status => :created, :location => @adventure }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @adventure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adventures/1
  # PUT /adventures/1.xml
  def update
    @adventure = Adventure.find(params[:id])

    respond_to do |format|
      if @adventure.update_attributes(params[:adventure])
        format.html { redirect_to(@adventure, :notice => 'Adventure was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @adventure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adventures/1
  # DELETE /adventures/1.xml
  def destroy
    @adventure = Adventure.find(params[:id])
    @adventure.destroy

    respond_to do |format|
      format.html { redirect_to(adventures_url) }
      format.xml  { head :ok }
    end
  end
end
