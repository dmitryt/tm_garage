class CreatePriorities < ActiveRecord::Migration
  def self.up
    create_table :priorities do |t|
      t.string :title, :limit => 10
      t.string :color, :limit => 10
      t.references :user
    end

    add_index :priorities, :title, :unique => true

    remove_column :tasks, :priority
    add_column :tasks, :priority_id, :integer
    
  end

  def self.down
    drop_table :priorities
    remove_column :tasks, :priority_id
    add_column :tasks, :priority, :integer
  end
end
