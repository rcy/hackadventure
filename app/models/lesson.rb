class Lesson
  include CouchPotato::Persistence

  property :name
  validates_presence_of :name

  property :body
  validates_presence_of :body

  property :deps
  validates_presence_of :deps

  view :by_name, :key => :name

  def self.all
    CouchPotato.database.view Lesson.by_name
  end

  def update hash
    self.name = hash[:name]
    self.body = hash[:body]
    self.deps = hash[:pretty_dependencies].to_s.downcase
  end

  def save!
    CouchPotato.database.save_document! self
  end

  def destroy!
    CouchPotato.database.destroy self
  end

  def pretty_dependencies
    deps.to_s.upcase
  end
end
