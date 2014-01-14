require 'spec_helper'

describe Course do

  it "should create a new course" do 
  	build(:course).should have(0).error_on :name
  end

  it "should not create duplicate courses" do
  	create(:course).should have(0).error_on :name
  	build(:course).should have(1).error_on :name
  end 

end
