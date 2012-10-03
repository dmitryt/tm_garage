class SetUsernameForUsers < ActiveRecord::Migration
  def self.up
	add_column :users, :username, :string, :limit => 30
    add_index :users, :username, :unique => true
  end

  def self.down
	remove_column :users, :username
    remove_index :users, :username
  end
end
