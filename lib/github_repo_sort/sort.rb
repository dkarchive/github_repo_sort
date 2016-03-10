# Sorting
module GitHubRepoSort
  require 'octokit'
  require 'netrc'
  require 'parallel'
  require 'ruby-progressbar'

  NETRC_GITHUB_MACHINE = 'api.github.com'

  class << self
    def info(c, list, name)
      info = []
      Parallel.each(list, :in_threads => 10, :progress => "Sorting") do |x|
        x = x.sub 'https://github.com/', ''

        begin
          r = c.repo x
        rescue => e
          # puts "Error: #{e}"
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
      puts ''

      info
    end

    def sort(list, options=nil, compact=true)
      if options.nil?
        by = 'stargazers_count'
        order = 'descending'
      else
        by = options['by']
        order = options['order']
      end

      c =
        if Netrc.read[NETRC_GITHUB_MACHINE].nil?
          Octokit
        else
          Octokit::Client.new(:netrc => true)
        end

      i = info(c, list, by) do |e|
        yield e if block_given?
      end

      s = i.sort { |x, y| x[by] <=> y[by] }

      if order == 'descending'
        s.reverse!
      end

      if compact
        s.map { |x| x['name'] }
      else
        s
      end
    end # sort
  end
end
