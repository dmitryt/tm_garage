class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, :dependent => :delete_all
  accepts_nested_attributes_for :tasks
end
