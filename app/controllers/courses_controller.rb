class CoursesController < ApplicationController
	def index
		@courses = Course.all
	end 

	def new
		@name = params[:name]
		@course = Course.new(name: @name)

		respond_to do |format|
			format.html
			format.json { render json: @course }
		end 
	end

	def create
		@name = params[:name]
		@course = Course.new(params[:course])

		respond_to do |format|
			if @course.save
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
