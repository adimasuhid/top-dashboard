# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'rubygems'
require File.expand_path('../config/application', __FILE__)

TopDashboard::Application.load_tasks

gem 'ci_reporter'
require 'ci/reporter/rake/rspec'
