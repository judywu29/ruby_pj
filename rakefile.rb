task :hello do
  puts "hello"
end

task :hello, :name do |t, args|
  puts "Hello, #{args.name} and #{t}"
end
