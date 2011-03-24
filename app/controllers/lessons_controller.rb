class LessonsController < ApplicationController
  def index
    @lessons = CouchPotato.database.view Lesson.all
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
    redirect_to :action => :index
  end

  def show
    @lesson= CouchPotato.database.load_document(params[:id])
  end

end
