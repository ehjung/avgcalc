class CoursesController < ApplicationController
	def index
		@courses = Course.all
	end 

	def new
		@new_course = Course.new

		respond_to do |format|
			format.html
			format.json { render json: @new_course }
		end 
	end

	def create
		@new_course = Course.new(params[:new_course])

		respond_to do |format|
			if @new_course.save
				format.html { redirect_to courses_path }
			end
		end 
	end 

	def edit
		@course = Course.find(params[:id])
	end 

	def update
		@course = Course.find(params[:id])

		respond_to do |format|
			if @course.update_attributes(params[:course])
				format.html { redirect_to courses_path }
			end
		end
	end 

	def destroy
		@course = Course.find(params[:id])

		respond_to do |format|
			if @course.destroy 
				format.html { redirect_to courses_path }
			end
		end
	end
end
