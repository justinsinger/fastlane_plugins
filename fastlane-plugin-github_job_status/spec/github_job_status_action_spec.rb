require 'fastlane'

describe Fastlane::Actions::GithubJobStatusAction do
  describe 'given all valid parameters' do
    it 'posts a valid status' do
      url = "https://api.github.com/repos/justinsinger/fastlane_plugins/statuses/commit_sha"
      headers = {
        'Authorization' => "token github_token",
        'User-Agent' => 'fastlane',
        'content_type' => :json,
        'accept' => :json
      }
      payload = {
        state: 'pending',
        description: 'Job pending',
        context: 'good_job',
        target_url: 'skullcrushers.gov'
      }

      expect(Fastlane::Actions::GithubJobStatusAction).to receive(:post).with(url, payload.to_json, headers)

      Fastlane::Actions::GithubJobStatusAction.run(
        token: 'github_token',
        owner: 'justinsinger',
        repo: 'fastlane_plugins',
        sha: 'commit_sha',
        job_name: 'good_job',
        build_url: 'skullcrushers.gov',
        state: 'pending'
      )
    end
  end

  describe 'given valid required parameters' do
    it 'posts a valid status' do
      url = "https://api.github.com/repos/justinsinger/fastlane_plugins/statuses/commit_sha"
      headers = {
        'Authorization' => "token github_token",
        'User-Agent' => 'fastlane',
        'content_type' => :json,
        'accept' => :json
      }
      payload = {
        state: 'pending',
        description: 'Job pending'
      }

      expect(Fastlane::Actions::GithubJobStatusAction).to receive(:post).with(url, payload.to_json, headers)

      Fastlane::Actions::GithubJobStatusAction.run(
        token: 'github_token',
        owner: 'justinsinger',
        repo: 'fastlane_plugins',
        sha: 'commit_sha',
        state: 'pending'
      )
    end
  end

  describe 'given an invalid status' do
    it 'throws an error' do
      fastfile = "lane :test do
        github_job_status(
          token: 'github_token',
          owner: 'justinsinger',
          repo: 'fastlane_plugins',
          sha: 'commit_sha',
          state: 'procrastinating'
        )
      end"
      expect { Fastlane::FastFile.new.parse(fastfile).runner.execute(:test) }.to(
        raise_error(FastlaneCore::Interface::FastlaneError) do |error|
          expect(error.message).to match(/Invalid state 'procrastinating' given\. State must be pending, success, error, or failure\./)
        end
      )
      expect(Fastlane::Actions::GithubJobStatusAction).not_to receive(:post)
    end
  end
end
