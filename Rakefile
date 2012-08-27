require 'bundler'
require 'rake/clean'
require 'rake/testtask'

include Rake::DSL

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
end
task :default => [:test]


