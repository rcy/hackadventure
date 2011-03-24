class Lesson
  include CouchPotato::Persistence

  property :name
  validates_presence_of :name

  property :body
  validates_presence_of :body

  property :deps

  view :all, :key => :name

  def save!
    CouchPotato.database.save_document! self
  end
end
