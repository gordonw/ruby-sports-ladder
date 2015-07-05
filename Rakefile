require 'rspec/core'
require 'rspec/core/rake_task'
require 'sinatra/activerecord/rake'

require './app.rb'

task :default  => :spec

RSpec::Core::RakeTask.new(:spec)

task :start do
  Rake::Task["db:reset"].invoke
  sh "rackup"
end