class Evaluation < ActiveRecord::Base
	attr_accessible :grade, :for, :weight

	validates_uniqueness_of :for
	validates_numericality_of :grade, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100
	validates_numericality_of :weight, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100
	
end
