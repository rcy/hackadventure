class AddUserAndTimestampsToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.references :user
    end
  end

  def self.down
    change_table :comments do |t|b
      t.remove :user
    end
  end
end
