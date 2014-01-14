FactoryGirl.define do 
	factory :course do
		name "Literature"
	end 

	factory :work do
		name "First test"
		thetype "Test"
	end

	factory :evaluation do 
		grade 77
		weight 50
	end
end