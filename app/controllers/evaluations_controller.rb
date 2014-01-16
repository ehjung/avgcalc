class EvaluationsController < ApplicationController
	before_filter :authenticate_user!, :except => [:create, :update, :destroy]
	def new
		@courseid = params[:courseid]
		@for = params[:id]
		@grade = params[:grade]
		@weight = params[:weight]
		@evaluation = Evaluation.new(:for => @for, grade: @grade, weight: @weight)

		if !(Course.where(:id => @courseid).first.userid == current_user.id)
			redirect_to courses_path
			flash[:alert] = 'This page does not exist.'
		else
			respond_to do |format|
				format.html
				format.json { render json: @evaluation }
			end 
		end
	end

	def create
		@evaluation = Evaluation.new(params[:evaluation])
		@courseid = Work.where(:id => @evaluation.for).first.courseid

		respond_to do |format|
			if !validWeight(@courseid, @evaluation.weight)
				format.html { redirect_to works_path(:courseid => @courseid), alert: 'Weights do not add up to 100%.' }
			else
				if @evaluation.save
					if !(Work.where(:id => @evaluation.for).first.courseid.nil?)
						@courseid = Work.where(:id => @evaluation.for).first.courseid
					else
						@courseid = params[:courseid]
					end 
					format.html { redirect_to works_path(:courseid => @courseid), notice: 'Evaluation was created.' }
				else
					format.html { redirect_to works_path(:courseid => @courseid), alert: 'Evaluation was not created.' }
				end
			end
		end 
	end 

	def edit
		@for = params[:for]
		@courseid = params[:courseid]
		@evaluation = Evaluation.find(params[:id])

		if !(Course.where(:id => @courseid).first.userid == current_user.id)
			redirect_to courses_path
			flash[:alert] = 'This page does not exist.'
		end
	end 

	def update
		@evaluation = Evaluation.find(params[:id])
		if Work.where(:id => @evaluation.for).exists?
			@courseid = Work.where(:id => @evaluation.for).first.courseid
		else
			@courseid = params[:courseid]
		end 
		respond_to do |format|
			if @evaluation.update_attributes(params[:evaluation])
				
				format.html { redirect_to works_path(:courseid => @courseid), notice: 'Evaluation was updated.' }
			else
				format.html { redirect_to works_path(:courseid => @courseid), alert: 'Evaluation was not updated.' }
			end
		end
	end 

	def destroy
		@evaluation = Evaluation.find(params[:id])
		if Work.where(:id => @evaluation.for).exists?
			@courseid = Work.where(:id => @evaluation.for).first.courseid
		else
			@courseid = params[:courseid]
		end 

		respond_to do |format|
			if @evaluation.destroy 
				format.html { redirect_to works_path(:courseid => @courseid), notice: 'Evaluation was deleted.' }
			else
				format.html { redirect_to works_path(:courseid => @courseid), alert: 'Evaluation was not deleted.' }
			end
		end
	end

end
