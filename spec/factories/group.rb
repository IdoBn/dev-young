FactoryGirl.define do
	factory :group do
		name Faker::Name.name
    address '1 Liberty Island, New York, NY 10004, USA'

		factory :group2 do
			name 'a group name'
		end
	end
end