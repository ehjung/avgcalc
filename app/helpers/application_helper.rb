module ApplicationHelper

	def computeAverage(courseid)
		@average = 0
		@works = Work.where(:courseid => courseid).all
		@works.each do |work|
			if Evaluation.where(:for => work).exists?
				grade = Evaluation.where(:for => work).first.grade
				weight = Evaluation.where(:for => work).first.weight
				@average += ((BigDecimal.new(grade) / 100) * weight)
			end
		end
		@average
	end

	def validWeight(courseid, new_weight)
		@totalweight = 0
		@works = Work.where(:courseid => courseid).all
		@works.each do |work|
			if Evaluation.where(:for => work).exists?
				@totalweight += Evaluation.where(:for => work).first.weight
			end
		end

		if @totalweight + new_weight > 100
			false
		else
			true
		end
	end


end
