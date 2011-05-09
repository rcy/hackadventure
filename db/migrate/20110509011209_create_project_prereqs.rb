class CreateProjectPrereqs < ActiveRecord::Migration
  def self.up
    create_table :project_prereqs do |t|
      t.integer :project_id
      t.integer :prereq_id

      t.timestamps
    end
  end

  def self.down
    drop_table :project_prereqs
  end
end
