class EvaluationsController < ApplicationController
	def new
		@courseid = params[:courseid]
		@thetype = params[:thetype]
		@name = params[:name]
		@work = Evaluation.new(courseid: @courseid, thetype: @thetype, name: @name)

		respond_to do |format|
			format.html
			format.json { render json: @work }
		end 
	end
=begin
	def create
		@courseid = params[:courseid]
		@thetype = params[:thetype]
		@name = params[:name]
		@work = Work.new(params[:work])

		respond_to do |format|
			if @work.save
				format.html { redirect_to works_path(:courseid => @work.courseid) }
			end
		end 
	end 

	def edit
		@courseid = params[:courseid]
		@work = Work.find(params[:id])
	end 

	def update
		@work = Work.find(params[:id])

		respond_to do |format|
			if @work.update_attributes(params[:work])
				format.html { redirect_to works_path(:courseid => @work.courseid) }
			end
		end
	end 

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
