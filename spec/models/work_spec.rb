require 'spec_helper'

describe Work do
	it "should create a new work" do
		new_user = create(:user)
		new_course = create(:course, userid: new_user.id)
		create(:work, :courseid => new_course).should have(0).error_on :name
	end

	it "should fail work duplication" do 
		new_user = create(:user)
		new_course = create(:course, userid: new_user.id)
		create(:work, :courseid => new_course).should have(0).error_on :name
		build(:work, :courseid => new_course).should have(1).error_on :name
	end

end
