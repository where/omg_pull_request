require 'bundler'
require 'rake/clean'
require 'rake/testtask'

include Rake::DSL

Rake::TestTask.new do |t|
  t.pattern = 'test/units/**/*_test.rb'
end

Rake::TestTask.new("test:integration") do |t|    
  t.pattern = 'test/integrations/**/*test.rb' 
end

namespace :test do
  task :setup do
    print "Github Login: "
    login = STDIN.gets.strip

    print "Github Password: "
    password = STDIN.gets.strip

    config = {:login => login, :password => password}
    File.open("test/integrations/config.yml", 'w') {|f| f.write(config.to_yaml) }
  end
end

task :default => [:test, "test:integration"]


