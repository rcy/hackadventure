class Project < ActiveRecord::Base
  validates :name, :presence => true
  validates :content, :presence => true

  belongs_to :adventure
  validates :adventure, :presence => true
end
