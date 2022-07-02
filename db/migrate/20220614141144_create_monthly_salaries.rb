class CreateMonthlySalaries < ActiveRecord::Migration[6.1]
  def change
    create_table :monthly_salaries do |t|
      t.string :month
      t.integer :monthly_working_days
      t.boolean :company_level, :default => false

      t.timestamps
    end
  end
end
