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
    cond = ["id not in (?)", completed_ids] unless completed_ids.blank?
    Project.find(:all, :conditions => cond, :include => :prereqs)
  end

  # returns incompleted projects that have satisfied dependencies
  def next_projects
    completed_ids = completed_projects.map(&:id)
    avail = []
    incompleted_projects.each do |ip|
      if (ip.prereq_ids - completed_ids).blank?
        avail.push ip
      end
    end
    avail
  end

  # FIXME: add field to db for this
  def is_admin?
    true
  end
end
