class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :priority

  validates :title, :presence => true, :uniqueness => true, :length => {:maximum => 50}
end
