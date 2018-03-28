require "rake/testtask"

Rake::TestTask.new do |t|
  t.test_files = FileList['tests/**/*_test.rb']
  t.verbose = true
end

desc "Run integration tests (via docker)"
task :integration do
  puts "Running integration tests via docker"
  system('docker build --no-cache -f tests/integration/Dockerfile -t ibuddy-integraion .')
end

desc "Run tests"
task default: :test
