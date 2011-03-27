class User
  include CouchPotato::Persistence

  #attr_accessible :email, :password, :password_confirmation

  property :email
  validates_presence_of :email

  property :password_hash
  validates_presence_of :password_hash

  attr_accessor :password
  #before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create

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
    if user && BCrypt::Password.new(user.password_hash) == password
      user
    else
      nil
    end
  end

end
