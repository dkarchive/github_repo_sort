# Command line interface
module GitHubRepoSort
  require 'github_repo_sort/version'
  require 'github_repo_sort/sort'

  class << self
    def usage
      puts "#{PROJECT} #{VERSION}"
      puts "Usage: #{PROJECT} <file>"
    end

    def cli
      if ARGV.count == 0
        usage
        exit
      end

      file = ARGV[0]
      begin
        c = File.read file
      rescue => e
        puts "Error: #{e}"
        exit
      end

      puts "Reading repos from #{file}"

      l = c.split "\n"
      puts "List: #{l}"

      s = sort(l) do |e|
        puts "Error: #{e}"
        puts "Aborting"
        exit
      end
      
      s.each { |x| puts x }
    end # cli
  end #class
end
