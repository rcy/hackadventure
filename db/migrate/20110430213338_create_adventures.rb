class CreateAdventures < ActiveRecord::Migration
  def self.up
    create_table :adventures do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :adventures
  end
end
