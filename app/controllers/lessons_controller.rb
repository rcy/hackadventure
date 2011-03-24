class LessonsController < ApplicationController
  before_filter :get_lessons

  def index
    respond_to do |format|
      format.html
      format.json { render :json => @lessons }
    end
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new
    @lesson.name = params[:lesson][:name]
    @lesson.body = params[:lesson][:body]
    @lesson.deps = params[:lesson][:deps]

    @lesson.save!
    redirect_to :action => :show, :id => @lesson.id
  end

  def show
    @lesson = CouchPotato.database.load_document(params[:id])
  end

  def edit
    @lesson = CouchPotato.database.load_document(params[:id])
  end

  def update
    @lesson = CouchPotato.database.load_document(params[:id])
    @lesson.update(params[:lesson])
    # @lesson.name = params[:lesson][:name]
    # @lesson.body = params[:lesson][:body]
    # @lesson.deps = params[:lesson][:deps]
    logger.debug @lesson.inspect
    @lesson.save!
    redirect_to @lesson
  end

  def destroy
    @lesson = CouchPotato.database.load_document params[:id]
    @lesson.destroy!
    redirect_to :action => :index
  end

  private
  def get_lessons
    @lessons = Lesson.all
  end

end
