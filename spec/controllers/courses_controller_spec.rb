require 'spec_helper'

describe CoursesController do

	it "GET index" do 
		get :index
		response.should render_template(:index)
	end

	it "GET new" do 
		get :new
		assigns(:course)
		response.should render_template(:new)
	end 

	# TODO:
	it "POST create without an account" do
		post :create, course: attributes_for(:course)
		response.should redirect_to courses_path
	end

=begin
	it "POST create with an account" do
		post :create, course: attributes_for(:course, userid: :user)
		response.should redirect_to courses_path
	end
=end 

	it "GET edit" do
		new_course = create(:course)
		get :edit, {id: new_course}
		response.should render_template(:edit)
	end 

	it "PUT update" do
		new_course = create(:course)
		put :update, id: new_course, course: attributes_for(:course, name: "Music")
		response.should redirect_to courses_path
	end 

	it "DELETE destroy when there is no work" do
		new_course = create(:course)
		delete :destroy, id: new_course
		response.should redirect_to courses_path
	end 

	it "DELETE destroy when there is work" do
		new_course = create(:course)
		new_work = create(:work, courseid: new_course)
		delete :destroy, id: new_course
		response.should redirect_to courses_path
	end 

	it "DELETE destroy when there is work and evaluation" do
		new_course = create(:course)
		new_work = create(:work, courseid: new_course)
		new_evaluation = create(:evaluation, for: new_work)
		delete :destroy, id: new_course
		response.should redirect_to courses_path
	end 

end
