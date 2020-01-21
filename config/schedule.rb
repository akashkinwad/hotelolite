# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
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

# Setup Cron Job command: whenever --update-crontab --set environment='development'
# Cron Job Listings command: crontab -l
# Cron Job Sytsem logs command: grep -i cron /var/log/syslog

set :output, {error: 'log/error.log', standard: 'log/cron.log'}

every 1.day, at: '11:59 pm' do
  runner "Subscription.deactivate_expiring_today"
  runner "Subscription.notify_user_about_subscription_expiry"
end
