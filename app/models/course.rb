class Course < ActiveRecord::Base
	attr_accessible :name, :average

    validates_uniqueness_of :name, :case_sensitive => false
end
