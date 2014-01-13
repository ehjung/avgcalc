class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.integer :courseid
      t.string :name
      t.string :thetype

      t.timestamps
    end
  end
end
