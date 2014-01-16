require 'spec_helper'

describe Evaluation do

  	describe "evaluation creation" do

		it "should create a new evaluation" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			build(:evaluation, :for => new_work).should have(0).error_on :for 
		end

		it "should fail duplicate evaluation" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			create(:evaluation, :for => new_work).should have(0).error_on :for 
			build(:evaluation, :for => new_work).should have(1).error_on :for 
		end
	end

	describe "grades" do

		it "should fail when negative grades created" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			build(:evaluation, :for => new_work, :grade => -77).should have(1).error_on :grade
		end

		it "should fail when grade over 100 created" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			build(:evaluation, :for => new_work, :grade => 107).should have(1).error_on :grade
		end

		it "should be able to have same mark for different assignment" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			create(:evaluation, :for => new_work).should have(0).error_on :grade
			other_new_work = create(:work, :courseid => new_course, :name => "Second Test")
			build(:evaluation, :for => other_new_work).should have(0).error_on :grade
		end

		it "should fail entering more than 1 mark for the same assignment" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			create(:evaluation, :for => new_work).should have(0).error_on :for
			build(:evaluation, :for => new_work, :grade => 33).should have(1).error_on :for
		end

		it "should fail decimal grades" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			build(:evaluation, :for => new_work, :grade => 86.2).should have(1).error_on :grade
		end
	end

	describe "weight" do

		it "should fail negative weight value" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			build(:evaluation, :for => new_work, :weight => -3).should have(1).error_on :weight
		end 

		it "should fail weight value above 100" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			build(:evaluation, :for => new_work, :weight => 324).should have(1).error_on :weight
		end 

		it "should fail decimal weight value" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			build(:evaluation, :for => new_work, :weight => 3.3).should have(1).error_on :weight
		end 

		it "should be between 0 and 100" do
			new_user = create(:user)
			new_course = create(:course, userid: new_user.id)
			new_work = create(:work, :courseid => new_course)
			build(:evaluation, :for => new_work).should have(0).error_on :weight
		end 
	end

end
