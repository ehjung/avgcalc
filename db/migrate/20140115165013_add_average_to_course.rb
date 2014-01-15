class AddAverageToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :average, :float
  end
end
