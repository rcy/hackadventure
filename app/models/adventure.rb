class Adventure < ActiveRecord::Base
  validates :name, :presence => true
  validates :description, :presence => true

  has_many :projects

  def to_s
    name.capitalize
  end
end
