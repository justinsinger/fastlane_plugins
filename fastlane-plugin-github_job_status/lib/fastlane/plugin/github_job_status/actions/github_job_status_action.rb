module Fastlane
  module Actions
    class GithubJobStatusAction < Action
      require 'rest-client'

      def self.run(params)
        api = "https://api.github.com/repos"
        url = "#{api}/#{params[:owner]}/#{params[:repo]}/statuses/#{params[:sha]}"

        headers = {
          'Authorization' => "token #{params[:token]}",
          'User-Agent' => 'fastlane',
          'content_type' => :json,
          'accept' => :json
        }

        payload = {
          state: params[:state],
          description: !params[:description] ? description_for_state(params[:state]) : params[:description]
        }
        context = params[:job_name]
        payload['context'] = context unless context.nil?
        target_url = params[:build_url]
        payload['target_url'] = target_url unless target_url.nil?

        begin
          post(url, payload.to_json, headers)
          true
        rescue RestClient::ExceptionWithResponse => e
          UI.error "Status failed to post to GitHub. Recieved the following response from the server: #{e.response}"
          false
        end
      end

      def self.post(url, payload, headers)
        RestClient.post(url, payload, headers)
      end

      def self.description_for_state(state)
        case state
        when 'pending'
          'Job pending'
        when 'success'
          'Job succeeded'
        when 'error'
          'Job failed'
        when 'failure'
          'Job unstable'
        end
      end

      def self.description
        "Post the status of your test jobs to your pull requests"
      end

      def self.authors
        ["Justin Singer"]
      end

      def self.return_value
        "True if status posted sucessfully, False otherwise"
      end

      def self.details
        "Uses github's status API (https://developer.github.com/v3/repos/statuses/) to display the status of continuous integration jobs directly on pull requests."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :token,
            env_name: 'GITHUB_JOB_STATUS_TOKEN',
            description: 'OAuth token for :owner GitHub account',
            verify_block: proc { |value| UI.user_error! "Token must be specified" if value.empty? }
          ),
          FastlaneCore::ConfigItem.new(
            key: :owner,
            env_name: 'GITHUB_JOB_STATUS_OWNER',
            description: 'The github owner or username',
            verify_block: proc { |value| UI.user_error! "Owner must be specified" if value.empty? }
          ),
          FastlaneCore::ConfigItem.new(
            key: :repo,
            env_name: 'GITHUB_JOB_STATUS_REPO',
            description: 'The github repo',
            verify_block: proc { |value| UI.user_error! "Repo must be specified" if value.empty? }
          ),
          FastlaneCore::ConfigItem.new(
            key: :sha,
            env_name: 'GITHUB_JOB_STATUS_SHA',
            description: 'The github sha of the commit',
            verify_block: proc { |value| UI.user_error! "SHA must be specified" if value.empty? }
          ),
          FastlaneCore::ConfigItem.new(
            key: :job_name,
            env_name: 'GITHUB_JOB_STATUS_JOB_NAME',
            description: 'The string displayed next to the status indicator but before the description',
            optional: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :description,
            env_name: 'GITHUB_JOB_STATUS_DESCRIPTION',
            description: 'The string displayed after job name',
            optional: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :build_url,
            env_name: 'GITHUB_JOB_STATUS_BUILD_URL',
            description: 'The url of the build upon which we are reporting the status',
            optional: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :state,
            env_name: 'GITHUB_JOB_STATUS_STATE',
            description: 'The state of a build; must be pending, success, error, or failure',
            verify_block: proc do |value|
              unless ['pending', 'success', 'error', 'failure'].include?(value)
                UI.user_error! "Invalid state '#{value}' given. State must be pending, success, error, or failure."
              end
            end
          )
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
