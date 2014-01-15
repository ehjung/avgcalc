require 'spec_helper'

describe EvaluationsController do
	it "GET new" do 
		get :new
		assigns(:evaluation)
		response.should render_template(:new)
	end

	it "POST create" do
		new_course = create(:course)
		new_work = create(:work, :courseid => new_course)
		post :create, courseid: new_course, evaluation: attributes_for(:evaluation, :for => new_work)
		response.should redirect_to works_path(:courseid => new_course)
	end


	it "GET edit" do
		new_course = create(:course)
		new_work = create(:work, :courseid => new_course)
		new_evaluation = create(:evaluation, :for => new_work)
		get :edit, {id: new_evaluation}
		response.should render_template(:edit)
	end 

	it "PUT update" do
		new_course = create(:course)
		new_work = create(:work, courseid: new_course)
		new_evaluation = create(:evaluation, :for => new_work)
		put :update, id: new_evaluation, courseid: new_course, evaluation: attributes_for(:evaluation, grade: 55, weight: 43)
		response.should redirect_to works_path(:courseid => new_course)
	end 

	it "DELETE destroy" do
		new_course = create(:course)
		new_work = create(:work, courseid: new_course)
		new_evaluation = create(:evaluation, :for => new_work)
		delete :destroy, id: new_evaluation, courseid: new_course
		response.should redirect_to works_path(:courseid => new_course)
	end 
 
end
