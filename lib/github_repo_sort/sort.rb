# Sorting
module GitHubRepoSort
  require 'github_repo_sort/repos'
  
  class << self
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

      i = repos(c, list, by) do |e|
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
