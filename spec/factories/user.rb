require 'faker'

FactoryGirl.define do
  factory :user do |f|
	f.username = { Faker::Internet.user_name }
	f.email = { Faker::Internet.email }
  end
end
