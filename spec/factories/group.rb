FactoryGirl.define do
	factory :group do
		name Faker::Name.name

		factory :group2 do
			name 'a group name'
		end
	end
end