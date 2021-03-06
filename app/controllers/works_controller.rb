class WorksController < ApplicationController
	before_filter :authenticate_user!, :except => [:create, :update, :destroy]
	def index
		@courseid = params[:courseid]
		if Course.where(:id => @courseid, :userid => current_user.id).exists?
			@works = Work.where(:courseid => @courseid).all 
		else 
			redirect_to courses_path
			flash[:alert] = 'Page not found.'
		end
	end

	def new
		@courseid = params[:courseid]
		@thetype = params[:thetype]
		@name = params[:name]
		@work = Work.new(courseid: @courseid, thetype: @thetype, name: @name)

		respond_to do |format|
			format.html
			format.json { render json: @work }
		end 
	end

	def create
		@work = Work.new(params[:work])

		respond_to do |format|
			if @work.save
				format.html { redirect_to works_path(:courseid => @work.courseid), notice: 'Work was created.' }
			else
				format.html { redirect_to works_path(:courseid => @work.courseid), alert: 'Work was not created.' }
			end
		end 
	end 

	def edit
		@courseid = params[:courseid]
		@work = Work.find(params[:id])

		if !(Course.where(:id => @courseid).exists? && (Course.where(:id => @courseid).first.userid == current_user.id))
			redirect_to courses_path
			flash[:alert] = 'This page does not exist.'
		end
	end 

	def update
		@work = Work.find(params[:id])

		respond_to do |format|
			if @work.update_attributes(params[:work])
				if @work.courseid.nil?
					@courseid = params[:courseid]
				else 
					@courseid = @work.courseid
				end 
				format.html { redirect_to works_path(:courseid => @courseid), notice: 'Work was updated.' }
			else
				format.html { redirect_to works_path(:courseid => @courseid), alert: 'Work was not updated.' }
			end
		end
	end 

	def destroy
		@work = Work.find(params[:id])
		@evaluations = Evaluation.where(:for => @work).all

		if @work.courseid.nil?
			@courseid = params[:courseid]
		else 
			@courseid = @work.courseid
		end 

		if @work.destroy
			@notice = 'Work was deleted.'
		else 
			@alert = 'Error while deleting work.'
		end 

		if !(@evaluations.empty?) 
			@evaluations.each do |evaluation|
				if evaluation.destroy
					@notice = 'Work was deleted and its corresponding evaluations.'
				else 
					@alert = 'Error while deleting work and its corresponding evaluations.'
				end 
			end
		end

		respond_to do |format|
			format.html { redirect_to works_path(:courseid => @courseid), notice: @notice, alert: @alert }
		end
	end

end
