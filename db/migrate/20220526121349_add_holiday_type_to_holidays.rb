class AddHolidayTypeToHolidays < ActiveRecord::Migration[6.1]
  def change
    add_column :holidays, :holiday_type, :string
  end
end
