class ProjectPrereq < ActiveRecord::Base
  belongs_to :project
  belongs_to :prereq, :class_name => "Project"
end
