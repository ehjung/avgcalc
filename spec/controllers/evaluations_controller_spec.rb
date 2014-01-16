require 'spec_helper'
include Devise::TestHelpers

describe EvaluationsController do

	it "GET new" do 
		new_user = create :user
		sign_in new_user
		new_course = create(:course, userid: new_user.id)
		new_work = create(:work, courseid: new_course.id)
		get :new, {userid: new_user.id, courseid: new_course.id}
		assigns(:evaluation)
		response.should render_template(:new)
	end

	it "POST create" do
		new_user = create(:user)
		new_course = create(:course, :userid => new_user.id)
		new_work = create(:work, :courseid => new_course)
		post :create, courseid: new_course, evaluation: attributes_for(:evaluation, :for => new_work)
		response.should redirect_to works_path(:courseid => new_course)
	end

	it "GET edit" do
		new_user = create(:user)
		sign_in new_user
		new_course = create(:course, userid: new_user.id)
		new_work = create(:work, :courseid => new_course)
		new_evaluation = create(:evaluation, :for => new_work)
		get :edit, {id: new_evaluation, userid: new_user.id, courseid: new_course.id}
		response.should render_template(:edit)
	end 

	it "PUT update" do
		new_user = create(:user)
		sign_in new_user
		new_course = create(:course, userid: new_user.id)
		new_work = create(:work, courseid: new_course)
		new_evaluation = create(:evaluation, :for => new_work)
		put :update, id: new_evaluation, courseid: new_course, evaluation: attributes_for(:evaluation, grade: 55, weight: 43)
		response.should redirect_to works_path(:courseid => new_course)
	end 

	it "DELETE destroy" do
		new_user = create(:user)
		new_course = create(:course, userid: new_user.id)
		new_work = create(:work, courseid: new_course)
		new_evaluation = create(:evaluation, :for => new_work)
		delete :destroy, id: new_evaluation, courseid: new_course
		response.should redirect_to works_path(:courseid => new_course)
	end 
end
