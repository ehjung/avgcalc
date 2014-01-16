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

	it "POST create without an account" do
		post :create, course: attributes_for(:course)
		flash[:alert].should == "Cannot create a course without an account."
	end

	it "POST create with an account" do
		new_user = create(:user)
		post :create, course: attributes_for(:course, userid: new_user.id)
		response.should redirect_to courses_path
	end

	it "GET edit" do
		new_user = create(:user)
		new_course = create(:course, userid: new_user.id)
		get :edit, {id: new_course}
		response.should render_template(:edit)
	end 

	it "PUT update" do
		new_user = create(:user)
		new_course = create(:course, userid: new_user.id)
		put :update, id: new_course, course: attributes_for(:course, name: "Music")
		response.should redirect_to courses_path
	end 

	it "DELETE destroy when there is no work" do
		new_user = create(:user)
		new_course = create(:course, userid: new_user.id)
		delete :destroy, id: new_course
		response.should redirect_to courses_path
	end 

	it "DELETE destroy when there is work" do
		new_user = create(:user)
		new_course = create(:course, userid: new_user.id)
		new_work = create(:work, courseid: new_course)
		delete :destroy, id: new_course
		response.should redirect_to courses_path
	end 

	it "DELETE destroy when there is work and evaluation" do
		new_user = create(:user)
		new_course = create(:course, userid: new_user.id)
		new_work = create(:work, courseid: new_course)
		new_evaluation = create(:evaluation, for: new_work)
		delete :destroy, id: new_course
		response.should redirect_to courses_path
	end 

end
