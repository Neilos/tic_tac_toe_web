require 'rake/testtask'

Rake::TestTask.new("test:unit") do |t|
  t.test_files = FileList['tests/unit/*.rb']
  t.verbose = true
end

Rake::TestTask.new("test:integration") do |t|
  t.test_files = FileList['tests/integration/*.rb']
  t.verbose = true
end


Rake::TestTask.new("test") do |t|
  t.test_files = FileList['tests/**/*.rb']
  t.verbose = true
end
