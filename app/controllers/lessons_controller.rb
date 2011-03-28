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
    @lesson.update(params[:lesson])
    @lesson.save!
    redirect_to :action => :show, :id => @lesson.id
  end

  def show
    @lesson = CouchPotato.database.load_document(params[:id])
    @next_lessons = Lesson.depends_on @lesson.id
    @prerequisites = @lesson.prerequisites
    @completed = current_user.completed_lesson_ids
  end

  def edit
    @lesson = CouchPotato.database.load_document(params[:id])
  end

  def update
    @lesson = CouchPotato.database.load_document(params[:id])
    @lesson.update(params[:lesson])
    @lesson.save!
    redirect_to @lesson
  end

  def destroy
    @lesson = CouchPotato.database.load_document params[:id]
    @lesson.destroy!
    redirect_to :action => :index
  end

  def completed
    u = current_user
    u.complete_lesson params[:id]

    respond_to do |format|
      format.html { render :text => "ok" }
      # format.json { render :json => @lessons }
    end
  end

  private
  def get_lessons
    @lessons = Lesson.all
  end

end
