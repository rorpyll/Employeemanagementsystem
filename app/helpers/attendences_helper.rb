module AttendencesHelper
	def attendence_graph(at)
		total_time = []
		start_time = at.first.checkin_time.beginning_of_day + 9.hours
		end_time = start_time + 12.hours

		for j in 0...at.length
			at[j].checkout_time = at[j].checkout_time.nil? ? at[j].checkin_time : at[j].checkout_time
			if j%2 == 0
				if at[j] == at.first
				else
					total_time << ((at[j].checkin_time - at[j - 1].checkout_time)/1.minutes ).abs
				end
				total_time << ((at[j].checkout_time - at[j].checkin_time)/1.minutes ).abs
			else
				total_time << ((at[j].checkin_time - at[j - 1].checkout_time)/1.minutes ).abs
				total_time << ((at[j].checkout_time - at[j].checkin_time)/1.minutes).abs 	 		
			end
		end
		total_time << ((end_time - at.last.checkout_time )/1.minutes).abs
		persent = []
		for i in 0...total_time.length
			persent[i]  = (total_time[i]/720)*100
		end
		return persent
	end
	def working_hour(at)
		hours = at.pluck(:hour)
		unless hours.include?(nil)
			hours.sum do |s|
  				h, m = s.split(':').map(&:to_i)
  				 60*h + m
			end.divmod(60).join(':')
		end
	end
	def checkin_checkout_time(at)
		time = []
		cit = at.pluck(:checkin_time) 
		cot = at.pluck(:checkout_time)
		for i in 0...cot.length 
			for z in 0...cit.length 
				if i == z
					store = cit[i].strftime("%I:%M%p - ") << cot[z].strftime("%I:%M%p")
					time << store 
				end 
				if i == z +1
					store = cot[z].strftime("%I:%M%p - ") << cit[i].strftime("%I:%M%p")
					time << store 
				end 
			end 
		end
		return time
	end
end
