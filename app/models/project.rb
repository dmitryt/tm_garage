class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, :dependent => :delete_all

  validates :title, :presence => true, :uniqueness => {:scope => :user_id}, :length => {:maximum => 50}
end
