class CoursesController < ApplicationController
	def index
		@courses = Course.all
		@overall_average = 0
		@courses.each do |course|
			average = computeAverage(course.id)
			course.update_attributes(:average => average)
			@overall_average += average
		end
		if @courses.count != 0
			@overall_average /= @courses.count
		end
	end 

	def new
		@name = params[:name]
		@average = params[:average]
		@course = Course.new(name: @name, average: 0)

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
				format.html { redirect_to courses_path, notice: 'Course has been created.' }
			else
				format.html { redirect_to courses_path, notice: 'This course already exists.' }
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
				format.html { redirect_to courses_path, notice: 'Course has been updated.' }
			else
				format.html { redirect_to courses_path, notice: 'This course already exists.' }
			end 
		end
	end 

	def destroy
		@course = Course.find(params[:id])
		@works = Work.where(:courseid => @course).all

		if @course.destroy
			@notice = 'Course has been deleted.'
		else 
			@notice = 'Error while deleting course.'
		end

		@works.each do |work|
			@evaluations = Evaluation.where(:for => work.id).all
			if work.destroy
				@notice = 'Course and its work have been deleted.'
			else
				@notice = 'Error while deleting course and its corresponding work.'
			end 
			@evaluations.each do |evaluation|
				if evaluation.destroy
					@notice = 'Course and its work and evaluations has been deleted.'
				else
					@notice = 'Error while deleting course and its corresponding work and evaluations.'
				end 
			end
		end

		
		respond_to do |format|
			format.html { redirect_to courses_path, notice: @notice }
		end
	end

end
