class ProjectPrereqsController < ApplicationController
  # GET /project_prereqs
  # GET /project_prereqs.xml
  def index
    @project_prereqs = ProjectPrereq.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_prereqs }
    end
  end

  # GET /project_prereqs/1
  # GET /project_prereqs/1.xml
  def show
    @project_prereq = ProjectPrereq.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project_prereq }
    end
  end

  # GET /project_prereqs/new
  # GET /project_prereqs/new.xml
  def new
    @project_prereq = ProjectPrereq.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_prereq }
    end
  end

  # GET /project_prereqs/1/edit
  def edit
    @project_prereq = ProjectPrereq.find(params[:id])
  end

  # POST /project_prereqs
  # POST /project_prereqs.xml
  def create
    @project_prereq = ProjectPrereq.new(params[:project_prereq])

    respond_to do |format|
      if @project_prereq.save
        format.html { redirect_to(@project_prereq, :notice => 'Project prereq was successfully created.') }
        format.xml  { render :xml => @project_prereq, :status => :created, :location => @project_prereq }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project_prereq.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /project_prereqs/1
  # PUT /project_prereqs/1.xml
  def update
    @project_prereq = ProjectPrereq.find(params[:id])

    respond_to do |format|
      if @project_prereq.update_attributes(params[:project_prereq])
        format.html { redirect_to(@project_prereq, :notice => 'Project prereq was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project_prereq.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /project_prereqs/1
  # DELETE /project_prereqs/1.xml
  def destroy
    @project_prereq = ProjectPrereq.find(params[:id])
    @project_prereq.destroy

    respond_to do |format|
      format.html { redirect_to(project_prereqs_url) }
      format.xml  { head :ok }
    end
  end
end
