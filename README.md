# github_repo_sort

Sort a list of GitHub repos (get GitHub repo information).

## Installation

```shell
$ git clone https://github.com/dkhamsing/github_repo_sort.git
$ cd github_repo_sort/
$ rake install
```

## Usage

```ruby
require 'github_repo_sort'

list = [
  'dkhamsing/awesome_bot',        # 116 stars
  'dkhamsing/podspec',            # 1 star
  'dkhamsing/update_profile_pic', # 4 stars
]

GitHubRepoSort::sort(list, {'by' => 'stargazer_count', 'order' => 'descending'})
# => ['dkhamsing/awesome_bot', 'dkhamsing/update_profile_pic', 'dkhamsing/podspec']

# note: star count descending is the default, so you could also use GitHubRepoSort(list)
# note: a data.json file is created with all the data gathered by github_repo_sort
```

What can you sort by?

- `forks_count`
- `network_count`
- `open_issues_count`
- `stargazer_count`
- `subscribers_count`
- `watchers_count`
- `size`

## Example

- [awesome status](https://github.com/dkhamsing/awesome_bot/blob/master/status)

## Contact

- [github.com/dkhamsing](https://github.com/dkhamsing)
- [twitter.com/dkhamsing](https://twitter.com/dkhamsing)

## License

This project is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
