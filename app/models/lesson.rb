class Lesson
  include CouchPotato::Persistence

  property :name
  validates_presence_of :name

  property :body
  validates_presence_of :body

  property :deps

  view :by_name, :key => :name
  view :by_id, :key => :_id
  view :by_dep, :key => :deps

  def pretty_name
    name
  end

  def self.all
    CouchPotato.database.view Lesson.by_name
  end

  def self.can_do
    CouchPotato.database.view Lesson.by_dep(:key => [])
  end

  def update params
    self.name = params[:name]
    self.body = params[:body]
    dep_names = params[:pretty_dependencies].to_s.downcase.split(/,/).map(&:strip)

    self.deps = dep_names.map do |name|
      doc = Lesson.find_by_name name
      unless doc
        doc = Lesson.new(:name => name, :body => 'EDITME', :deps => [])
        doc.save!
      end
      doc.id
    end
  end

  def self.find_all_by_name name
    CouchPotato.database.view Lesson.by_name(:key => name)
  end

  def self.find_by_name name
    self.find_all_by_name(name).first
  end

  def save!
    CouchPotato.database.save_document! self
  end

  def destroy!
    # TODO: check if this lesson is a prereq for any other
    CouchPotato.database.destroy self
  end

  def prerequisites
    if deps && deps.is_a?(Array)
      deps.map do |id|
        CouchPotato.database.load_document(id)
      end
    else
      []
    end
  end

  def pretty_dependencies
    prerequisites.map(&:name).join(',')
  end
end
