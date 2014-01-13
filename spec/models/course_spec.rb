require 'spec_helper'

describe Course do
  it "should create a new course" do 
  	@new_course = Course.create(name: "Math")
  	expect(Course.where(:id => @new_course).exists?).to eq(true)
  end

  it "should not create duplicate courses" do
  	@other_new_course = Course.create(name: "Math")
  	expect(Course.where(:id => @other_new_course).exists?).to eq(false)
  end 

end
