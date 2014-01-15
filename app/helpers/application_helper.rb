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

end
