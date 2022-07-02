class AddReferencetosalary < ActiveRecord::Migration[6.1]
  def change
    add_reference :salaries, :monthly_salary, index: true
    add_column :salaries, :download_status, :boolean, :default => true
  end
end
