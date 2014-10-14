require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/so_far_so_good*.rb'
  test.verbose = true
end

desc "Open console with So FAR So Good loaded"
task :console do
  exec "pry -r ./lib/so_far_so_good.rb"
end
