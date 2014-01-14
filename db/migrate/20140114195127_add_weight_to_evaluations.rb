class AddWeightToEvaluations < ActiveRecord::Migration
  def change
    add_column :evaluations, :weight, :integer
  end
end
