class Course < ActiveRecord::Base
	attr_accessible :name, :average

	before_save :set_default_average

    validates_uniqueness_of :name, :case_sensitive => false
   	validates_length_of :name, :minimum => 1, :maximum => 200
   	

   	def set_default_average
     self.average = 0 unless self.average
     validates_numericality_of :average, :greater_than_or_equal =>  0, :less_than_or_equal => 100
   end

end
