class LessonsController < ApplicationController
  before_filter :get_lessons

  def index
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
    @lesson.name = params[:lesson][:name]
    @lesson.body = params[:lesson][:body]
    @lesson.deps = params[:lesson][:deps]
    @lesson.save!
    redirect_to @lesson
  end

  private
  def get_lessons
    @lessons = CouchPotato.database.view Lesson.all
  end

end
