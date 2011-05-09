class Project < ActiveRecord::Base
  validates :name, :presence => true
  validates :content, :presence => true

  belongs_to :adventure
  validates :adventure, :presence => true

  has_many :solutions
  has_many :comments, :as => :commentable

  has_many :completions
  has_many :users_completed, :through => :completions, :source => :user

  has_many :project_prereqs
  has_many :prereqs, :through => :project_prereqs

  # return non-nil if USER has completed this project
  def completed? user
    completions.find_by_user_id user.id
  end

  def to_s
    name
  end
end
