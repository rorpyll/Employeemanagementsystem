module SalariesHelper
	def pdf(monthlysalary)
		monthlysalary.updated_at.to_date + 2.day > Time.now.to_date
	end
end
