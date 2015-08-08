require 'rake'
require 'rake/testtask'
#require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

desc 'Clean, test and install app'
task :default => [:test, :install]

desc 'test'
task :test => [:clean, :unitTest]

desc 'Remove coverage and pkg dirs before compilation'
task :clean do
  rm_rf %w(coverage pkg)
end

desc 'Run Unittests'
Rake::TestTask.new(:unitTest) do |t|
  t.libs << 'test'
  t.verbose = false
  t.test_files = FileList['test/*_test.rb']
end
