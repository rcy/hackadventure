class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :completions
  has_many :completed_projects, :through => :completions, :source => :project

  def name
    email
  end

  def to_s
    email.split('@').first
  end

  def incompleted_projects
    completed_ids = completed_projects.map(&:id)
    Project.find(:all, :conditions => ["id not in (?)", completed_ids])
  end

  # FIXME: add field to db for this
  def is_admin?
    true
  end
end
