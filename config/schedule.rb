# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, '/home/freedom/projects/Employeemanagementsystem/log/cron_log.log'

set :environment, 'development'
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
job_type :sidekiq, 'cd :path && :environment_variable=:environment bundle exec rails runner :task :output'

every 1.months, roles: %i[app web] do
  sidekiq 'LeaveBalanceJob.perform_now'
end

# every 1.month, roles: [:web] do
#   sidekiq 'TotalSalaryJob'
# end

# every 1.day, roles: [:app] do
#   sidekiq 'AttendenceJob'
# end
