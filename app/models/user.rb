class User
  include CouchPotato::Persistence

  #attr_accessible :email, :password, :password_confirmation

  property :email
  validates_presence_of :email

  property :password_hash
  validates_presence_of :password_hash

  attr_accessor :password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create

  property :completed_lesson_ids, :default => []

  view :by_email, :key => :email

  def save
    puts "save: got here"
    CouchPotato.database.save_document self
  end

  def save!
    puts "save!: got here"
    puts "user: #{self.inspect}"
    CouchPotato.database.save_document self
    puts "save!: got here2"
  end

  def encrypt_password
    self.password_hash = BCrypt::Password.create(password)
  end

  def self.find_by_email(email)
    CouchPotato.database.view(User.by_email(:key => email)).first
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user
      hash = BCrypt::Password.new(user.password_hash)
      if hash == password
        user
      else
        nil
      end
    else
      nil
    end
  end

  def completed? lesson_id
    self.completed_lesson_ids.find_index(lesson_id) if self.completed_lesson_ids
  end

  def complete_lesson lesson_id, value
    ids = self.completed_lesson_ids || []
    puts "complete_lesson: #{self.completed_lesson_ids}"

    if value == true
      unless completed? lesson_id
        ids << lesson_id
        puts "got here: #{self.dirty?.inspect}"
        puts "got here: #{self.dirty?.inspect}"
      end
    else
      ids.delete_if {|i| i == lesson_id}
    end
    self.completed_lesson_ids = 'dirty' # hack to force dirtying object
    self.completed_lesson_ids = ids
    self.save!
    puts "complete_lesson: #{self.completed_lesson_ids}"
  end

end
