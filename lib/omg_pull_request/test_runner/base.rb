module OmgPullRequest
  module TestRunner
    class Base
      attr_accessor :success, :runtime, :pull_request, :configuration, :github_wrapper, :store
      include Notifications

      def initialize(attributes={})
        attributes.each do |attr, value|
          self.send("#{attr}=", value)
        end
        self.success = false
      end

      [:setup, :execute_tests, :teardown].each do |method| 
        define_method method do; true; end;
      end

      def run
        log_test_details!
        make_comment_test_running!
        make_status_test_running!

        git_client.checkout!(from_sha)
        merge_response = git_client.merge!(to_sha)

        if merge_response == :conflict
          make_comment_conflict!
          make_status_conflict!
          return
        end

        Bundler.with_clean_env do
          setup

          t = Time.now
          self.success = execute_tests
          self.runtime =  Time.now - t

          teardown
        end

        process_output!
      end

      def success?
        self.success
      end

      def runtime_minutes
        (runtime.to_f / 60).to_i
      end

      def runtime_seconds
        (runtime.to_f % 60).round(3)
      end

      def from_sha
        pull_request.base.sha
      end

      def to_sha
        pull_request.head.sha
      end

      def request_sha
        "#{self.from_sha}:#{self.to_sha}"
      end

      def abbr_from_sha
        self.from_sha[0, 8]
      end

      def abbr_to_sha
        self.to_sha[0, 8]
      end

      def issue_number
        pull_request.number
      end

      def logger
        @logger ||= TestLogger.new(:store => self.store)
      end

      def prowl_client
        @prowl_client ||= Prowl.new(:configuration => self.configuration, :logger => logger, :runner => self, :github_wrapper => self.github_wrapper)
      end

      def lolcommits_client
        @lolcommits ||= Lolcommits.new(:configuration => self.configuration, :github_wrapper => self.github_wrapper, :runner => self, :context => CONTEXT)
      end

      def git_client
        @git_client ||= GitClient.new(:logger => logger, :configuration => self.configuration)
      end

      def notifier
        @notifier ||= Notifier.new(:runner => self, :github_wrapper => self.configuration)
      end

      def log(message)
        logger.log(message)
      end

      protected
      # execute shell command, return true if success
      def execute!(command)
        log `#{command} 2>&1`
        exit_code = $?.to_i
        success = exit_code == 0
      end

      def log_test_details!
        log t("start.banner", runner_hash(:version => VERSION))
      end

      def store_logger_data!
        logger.store_logs!("#{abbr_from_sha}-#{abbr_to_sha}-#{Time.now.to_i}.txt")
      end

      extend Configuration::Helpers
      delegate_config_to(:configuration, :local_repo, :database_yml)

      def t(key, options=Hash.new)
        I18n.t(key, options)
      end

    end
  end
end
