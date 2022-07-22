# frozen_string_literal: true

module AttendencesHelper
  def attendence_graph(at)
    total_time = []
    start_time = at.first.checkin_time.beginning_of_day + 9.hours
    end_time = start_time + 12.hours

    (0...at.length).each do |j|
      at[j].checkout_time = at[j].checkout_time.nil? ? at[j].checkin_time : at[j].checkout_time
      if j.even?
        if at[j] == at.first
        else
          total_time << ((at[j].checkin_time - at[j - 1].checkout_time) / 1.minutes).abs
        end
      else
        total_time << ((at[j].checkin_time - at[j - 1].checkout_time) / 1.minutes).abs
      end
      total_time << ((at[j].checkout_time - at[j].checkin_time) / 1.minutes).abs
    end

    total_time << ((end_time - at.last.checkout_time) / 1.minutes).abs
    persent = []
    (0...total_time.length).each do |i|
      persent[i] = (total_time[i] / 720) * 100
    end
    persent
  end

  def working_hour(at)
    hours = at.pluck(:hour)
    unless hours.include?(nil)
      hours.sum do |s|
        h, m = s.split(':').map(&:to_i)
        60 * h + m
      end.divmod(60).join(' hours ')
    end
  end

  def checkin_checkout_time(at)
    time = []
    cit = at.pluck(:checkin_time)
    cot = at.pluck(:checkout_time)
    (0...cot.length).each do |i|
      (0...cit.length).each do |z|
        if i == z
          store = cit[i].strftime('%I:%M%p - ') << cot[z].strftime('%I:%M%p')
          time << store
        end
        if i == z + 1
          store = cot[z].strftime('%I:%M%p - ') << cit[i].strftime('%I:%M%p')
          time << store
        end
      end
    end
    time
  end
end
