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
				if !(Work.where(:id => @evaluation.for).first.courseid.nil?)
					@courseid = Work.where(:id => @evaluation.for).first.courseid
				else
					@courseid = params[:courseid]
				end 
				format.html { redirect_to works_path(:courseid => @courseid), notice: 'Evaluation was created.' }
			else
				format.html { redirect_to works_path(:courseid => @courseid), notice: 'Evaluation was not created.' }
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
				if Work.where(:id => @evaluation.for).exists?
					@courseid = Work.where(:id => @evaluation.for).first.courseid
				else
					@courseid = params[:courseid]
				end 
				format.html { redirect_to works_path(:courseid => @courseid), notice: 'Evaluation was updated.' }
			else
				format.html { redirect_to works_path(:courseid => @courseid), notice: 'Evaluation was not updated.' }
			end
		end
	end 

	def destroy
		@evaluation = Evaluation.find(params[:id])

		respond_to do |format|
			if @evaluation.destroy 
				format.html { redirect_to works_path(:courseid => params[:courseid]), notice: 'Evaluation was deleted.' }
			else
				format.html { redirect_to works_path(:courseid => params[:courseid]), notice: 'Evaluation was not deleted.' }
			end
		end
	end

end
