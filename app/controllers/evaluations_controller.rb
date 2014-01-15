class EvaluationsController < ApplicationController
	def new
		@courseid = params[:courseid]
		@for = params[:id]
		@grade = params[:grade]
		@weight = params[:weight]
		@evaluation = Evaluation.new(:for => @for, grade: @grade, weight: @weight)

		respond_to do |format|
			format.html
			format.json { render json: @evaluation }
		end 
	end

	def create
		@evaluation = Evaluation.new(params[:evaluation])

		respond_to do |format|
			if @evaluation.save
				@courseid = Work.where(:id => @evaluation.for).first.courseid
				format.html { redirect_to works_path(:courseid => @courseid) }
			end
		end 
	end 

	def edit
		@for = params[:id]
		@courseid = params[:courseid]
		@evaluation = Evaluation.find(params[:id])
	end 

	def update
		@evaluation = Evaluation.find(params[:id])
		respond_to do |format|
			if @evaluation.update_attributes(params[:evaluation])
				@courseid = Work.where(:id => @evaluation.for).first.courseid
				format.html { redirect_to works_path(:courseid => @courseid) }
			end
		end
	end 
=begin
	def destroy
		@work = Work.find(params[:id])

		respond_to do |format|
			if @work.destroy 
				format.html { redirect_to works_path }
			end
		end
	end
=end 
end
