class CreateDesignations < ActiveRecord::Migration[6.1]
  def change
    create_table :designations do |t|
      t.string :name

      t.timestamps
    end
  end
end
