require 'rake'
require 'rake/testtask'
#require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

task :default => :test

#desc 'Clean workspace. Run RuboCop. Run spec and unittests, and build.'
#task :test => [:clean, :rubocop, :specTest, :unitTest, :build]
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
  t.test_files = FileList['test/unitTests/*_test.rb']
end
