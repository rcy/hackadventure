class Project < ActiveRecord::Base
  validates :name, :presence => true
  validates :content, :presence => true

  belongs_to :adventure
  validates :adventure, :presence => true

  has_many :solutions
  has_many :comments, :as => :commentable

  has_many :completions
  has_many :users_completed, :through => :completions, :source => :user
end
