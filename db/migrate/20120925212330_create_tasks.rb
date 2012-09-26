class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :title, :null => false
      t.references :project
      t.integer :priority, :default => 0

      t.boolean :finished, :default => false
      t.date :deadline_at

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
