require 'spec_helper'

describe Work do
  it "should create a new work" do
  	@new_work = Work.create(courseid: @new_course, name: "Algebra", thetype: "Test")
  	expect(Work.where(:id => @new_work).exists?).to eq(true)
  end
end
