require 'spec_helper'

describe WorksController do
	it "GET index" do 
		get :index
		response.should render_template(:index)
	end

	it "GET new" do 
		get :new
		assigns(:work)
		response.should render_template(:new)
	end 

	it "POST create" do
		new_course = create(:course)
		post :create, courseid: new_course, work: attributes_for(:work, courseid: new_course)
		response.should redirect_to works_path(:courseid => new_course)
	end

	it "GET edit" do
		new_course = create(:course)
		new_work = create(:work, courseid: new_course)
		get :edit, {id: new_work}
		response.should render_template(:edit)
	end 

	it "PUT update" do
		new_course = create(:course)
		new_work = create(:work, courseid: new_course)
		put :update, id: new_work, work: attributes_for(:work, name: "Test2")
		response.should redirect_to works_path
	end 

	it "DELETE destroy" do
		new_course = create(:course)
		new_work = create(:work, courseid: new_course)
		delete :destroy, id: new_work
		response.should redirect_to works_path
	end 
end
