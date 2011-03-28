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
    @prerequisites = @lesson.prerequisites
    @next = @lesson.next_lessons
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
    if params[:completed] == "1"
      u.complete_lesson params[:id], true
      flash[:notice] = "Well done! Marked lesson as completed."
    else
      u.complete_lesson params[:id], false
      flash[:notice] = "Marked lesson as NOT completed"
    end

    respond_to do |format|
      format.html do
        if request.xhr?
          render :text => flash[:notice]
          flash[:notice] = nil
        else
          redirect_to :action => :show, :id => params[:id]
        end
      end
      # format.json { render :json => @lessons }
    end
  end

  private
  def get_lessons
    @lessons = Lesson.all

    # compute the set of lessons that have all prerequisites satisfied
    # that have not been completed yet
    @available = []
    @completed = []
    @other = []
    @lessons.each do |lesson|
      if current_user.completed?(lesson.id)
        @completed << lesson
      elsif lesson.missing_prerequisites(current_user.completed_lesson_ids).blank?
        @available << lesson
      else
        # its neither completed nor has satisfied dependencies
        @other << lesson
      end
    end
  end
end
