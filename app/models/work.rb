class Work < ActiveRecord::Base
	attr_accessible :courseid, :name, :thetype 	

	validates_uniqueness_of :name, :case_sensitive => false, :scope => :courseid, presence: true

	validates :courseid, exclusion: nil 

	validates :thetype, inclusion: %w(Test Quiz Exam Assignment Lab)
	
end
