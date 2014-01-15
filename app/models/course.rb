class Course < ActiveRecord::Base
	attr_accessible :name, :average, :userid 

	before_save :set_default_average
	validate :userid_exists

    validates_uniqueness_of :name, :case_sensitive => false
   	validates_length_of :name, :minimum => 1, :maximum => 200
   	

   	def set_default_average
     average = 0 unless average
     validates_numericality_of :average, :greater_than_or_equal =>  0, :less_than_or_equal => 100
   end

   def userid_exists
   	if (!User.where(:id => userid).exists?) || !signed_in? 
   		errors[:userid] << "cannot be created without valid account"
   	else
   		return
   	end
   end 



end
