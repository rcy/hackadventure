class LessonsController < ApplicationController
  #before_filter :get_lessons

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
    @prerequisites = @lesson.prerequisites

    @lessons = Lesson.all
    # @next_lessons = Lesson.depends_on @lesson.id
    # @completed = current_user.completed_lesson_ids

    # compute the set of lessons that have all prerequisites satisfied
    # that have not been completed yet
    @available = []
    @lessons.each do |lesson|
      if (lesson.missing_prerequisites(current_user.completed_lesson_ids).blank? and not current_user.completed?(lesson.id))
        @available << lesson
      end
    end
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

end
