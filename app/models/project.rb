class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, :dependent => :delete_all

  validates :title, :presence => true, :uniqueness => true, :length => {:maximum => 3}
end
