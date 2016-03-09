require 'github_repo_sort'

puts 'Testing github_repo_sort'

c = File.read ARGV[0]
l = c.split "\n"
puts "List to sort: #{l}"

s = GitHubRepoSort::sort(l) do |e|
  puts "Error: #{e}"
  puts "Aborting test"
  exit
end
puts "Sorted: #{s}"

exit 1 if s[0] != 'dkhamsing/awesome_bot'
puts '✅'
