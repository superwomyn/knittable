# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'rubocop/rake_task'

RuboCop::RakeTask.new
task(:default).clear
task default: [:rubocop]