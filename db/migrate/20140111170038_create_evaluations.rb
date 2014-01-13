class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :grade
      t.integer :for

      t.timestamps
    end
  end
end
