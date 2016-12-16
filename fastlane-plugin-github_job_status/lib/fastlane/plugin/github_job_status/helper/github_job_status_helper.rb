module Fastlane
  module Helper
    class GithubJobStatusHelper
      # class methods that you define here become available in your action
      # as `Helper::GithubJobStatusHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the github_job_status plugin helper!")
      end
    end
  end
end
