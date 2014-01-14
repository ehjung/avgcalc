require 'spec_helper'

describe Work do
	
	it "should create a new work" do
		new_course = create(:course)
		create(:work, :courseid => new_course).should have(0).error_on :name
	end

	it "should fail work duplication" do 
		new_course = create(:course)
		create(:work, :courseid => new_course).should have(0).error_on :name
		build(:work, :courseid => new_course).should have(1).error_on :name
	end
end
