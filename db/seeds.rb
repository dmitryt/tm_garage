# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Priority.delete_all
[{:title => 'default', :color => '#A9F8AD'}, {:title => 'critical', :color => '#F8A9A9'}, {:title => 'minor', :color => '#C0BFFC'}].each do |data|
  Priority.create(data)
end

Task.update_all(:priority_id => Priority.first)
