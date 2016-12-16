# github_job_status plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-github_job_status)

## Getting Started

This project is a [fastlane](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-github_job_status`, add it to your project by running:

```bash
fastlane add_plugin github_job_status
```

## About github_job_status

Post the status of your test jobs to your pull requests. This uses GihHub's [status API](https://developer.github.com/v3/repos/statuses/). Statuses posted to pull requests look this:
![screen shot 2016-12-16 at 2 25 20 pm](https://cloud.githubusercontent.com/assets/8180094/21275606/98432cc4-c39b-11e6-984f-25228455efd7.png)

This plugin can be used in the following way:

```RUBY
github_job_status(
  token: 'github_OAuth_token',
  owner: 'justinsinger',
  repo: 'fastlane_plugins',
  sha: 'commit_sha',
  job_name: 'good_job',
  build_url: 'skullcrushers.gov',
  state: 'pending'
)
```

 * `state` must be pending, success, error, or failure
 * `token` can be obtained in GitHub for an owner (To do this, go to settings/Personal access tokens. Generate a new token and be sure to enable `repo:status`.)
 * `job_name` and  `build_url` are optional, but all other parameters are required

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/PluginsTroubleshooting.md) doc in the main `fastlane` repo.

## Using `fastlane` Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Plugins.md).

## About `fastlane`

`fastlane` is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
