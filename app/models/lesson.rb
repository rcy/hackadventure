class Lesson
  include CouchPotato::Persistence

  property :name
  validates_presence_of :name

  property :body
  validates_presence_of :body

  property :deps

  view :by_name, :key => :name
  view :by_id, :key => :_id

  def pretty_name
    name
  end

  def self.all
    CouchPotato.database.view Lesson.by_id
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
    # TODO: check if this lesson is a prereq for any other
    CouchPotato.database.destroy self
  end

  def prerequisites
    if deps
      deps.split(/,/).map do |id|
        CouchPotato.database.load_document(id) || Lesson.new(:name => id)
      end
    else
      []
    end
  end

  def pretty_dependencies
    deps.to_s.upcase
  end
end
