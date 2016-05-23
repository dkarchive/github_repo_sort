# Get repos
module GitHubRepoSort
  require 'octokit'
  require 'netrc'
  require 'parallel'
  require 'ruby-progressbar'

  NETRC_GITHUB_MACHINE = 'api.github.com'

  class << self
    def repos(c, list, name)
      info = []
      Parallel.each(list, :in_threads => 10, :progress => "Sorting") do |x|
        x = x.sub 'https://github.com/', ''
        x = x.strip

        begin
          r = c.repo x
        rescue => e
          puts "Issue with #{x}"
          yield e
          next
        end

        i = {
          'name' => x,
          name => r[name],
          'raw' => r
        }

        info.push i
      end # parallel

      info
    end
  end
end
