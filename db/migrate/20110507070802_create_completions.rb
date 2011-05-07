class CreateCompletions < ActiveRecord::Migration
  def self.up
    create_table :completions do |t|
      t.references :user
      t.references :project

      t.timestamps
    end
  end

  def self.down
    drop_table :completions
  end
end
