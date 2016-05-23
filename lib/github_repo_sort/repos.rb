# Get repos
module GitHubRepoSort
  require 'octokit'
  require 'netrc'
  require 'parallel'
  require 'ruby-progressbar'
  require 'json'
  # require 'pp'

  NETRC_GITHUB_MACHINE = 'api.github.com'
  OUTPUT = 'data.json'

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

        # pp r

        data = {
          'stargazers_count' => r['stargazers_count'],
          'pushed_at' => r['pushed_at']
        }

        i = {
          'name' => x,
          name => r[name],
          'data' => data,
          'raw' => r
        }

        info.push i
      end # parallel

      File.open(OUTPUT, 'w') { |f| f.write JSON.pretty_generate(info) }

      info
    end
  end
end
