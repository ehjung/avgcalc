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

	it "POST create" do
		post :create, course: attributes_for(:course)
		response.should redirect_to courses_path
	end

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

	it "DELETE destroy" do
		new_course = create(:course)
		delete :destroy, id: new_course
		response.should redirect_to courses_path
	end 

end
