class Lesson
  include CouchPotato::Persistence

  property :name
  validates_presence_of :name

  property :body

  property :deps

  property :published, :default => false

  view :by_name, :key => :name
  view :by_id, :key => :_id
  view :by_dep, :map => <<END_JS, :include_docs => true, :type => :custom
function(doc) {
  if(doc.ruby_class && doc.ruby_class == 'Lesson') {
    if (doc.deps.length > 0) {
      for (d in doc.deps) {
        emit(doc.deps[d], doc._id);
      }
    } else {
        emit(null, doc._id);
    }
  }
}
END_JS

  def pretty_name
    name.sub(/^meta:/,'')
  end

  def self.all
    CouchPotato.database.view Lesson.by_name
  end

  def self.can_do
    # FIXME: this should return all lessons with satisfied dependencies, not just ones with nil deps
    self.depends_on nil
  end

  def self.depends_on id
    CouchPotato.database.view Lesson.by_dep(:key => id)
  end

  def update params
    self.name = params[:name]
    self.body = params[:body]
    self.published = params[:published]
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

  # return lessons that have this as a prerequisite
  def next_lessons
    Lesson.depends_on self.id
  end

  def pretty_dependencies
    prerequisites.map(&:name).join(',')
  end

  # return the set of lesson ids not completed
  def missing_prerequisites completed_lesson_ids = nil
    self.deps - (completed_lesson_ids || [])
  end

  # return the set of lesson ids that have been completed
  def satisfied_prerequisites completed_lesson_ids = nil
    self.deps & (completed_lesson_ids || [])
  end

  def published?
    self.published.to_s == '1'
  end
end
