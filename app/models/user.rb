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

  property :completed_lesson_ids

  view :by_email, :key => :email

  def save
    self.password_hash = BCrypt::Password.create(password)
    CouchPotato.database.save_document self
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
    self.completed_lesson_ids ||= []

    if value == true
      unless completed? lesson_id
        self.completed_lesson_ids << lesson_id
        self.save
      end
    else
      self.completed_lesson_ids.delete_if {|e| e == lesson_id}
      self.save
    end
  end

end
