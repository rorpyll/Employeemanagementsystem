class Addleavecounttoemployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :leave_count, :integer, default: 0
  end
end
