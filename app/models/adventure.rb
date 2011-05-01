class Adventure < ActiveRecord::Base
  validates :name, :presence => true
  validates :description, :presence => true
  has_many :projects
  has_many :comments, :as => :commentable

  def to_s
    name.capitalize
  end

  # return just the first line of the description
  def short_description
    description.split(/\n/).first
  end
end
