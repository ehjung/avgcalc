class AddUseridToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :userid, :integer
  end
end
