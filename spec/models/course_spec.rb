require 'spec_helper'

describe Course do

  it "shouldn't create a new course without an account" do 
  	build(:course).should have(1).error_on :userid
  end

  it "should not create duplicate courses" do
  	create(:course).should have(0).error_on :name
  	build(:course).should have(1).error_on :name
  end 

end
