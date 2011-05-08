class Solution < ActiveRecord::Base
  belongs_to :project
  has_many :comments, :as => :commentable

  def title
    "Solution to: #{project.name}"
  end
end
