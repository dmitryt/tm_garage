class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :priority

  validates :title, :presence => true, :uniqueness => {:scope => :project_id}, :length => {:maximum => 50}

  before_create :set_priority

  def set_priority
    self.priority = Priority.first
  end
end
