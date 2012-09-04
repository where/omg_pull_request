module OmgPullRequest
  module TestRunner

    def self.start_daemon(configuration=Configuration.new, daemonize=true)
      configuration.initialize_localization!
      github_wrapper    = GithubWrapper.new(
        :configuration => configuration
      )

      store = configuration.storage_class.new(
        :configuration => configuration,
        :github_wrapper => github_wrapper
      )

      while(true)
        begin
          github_wrapper.pull_requests.each do |pr|
            runner = configuration.runner_class.new(
              :configuration  => configuration, 
              :pull_request   => pr, 
              :github_wrapper => github_wrapper,
              :store          => store
            )
            next if CONTEXT.ran?(runner.request_sha)
            CONTEXT.ran(runner.request_sha)

            runner.run
          end

        rescue => ex
          puts "An Error Occured: #{ex.inspect}\n#{ex.backtrace}"
        end

        return if daemonize == false
        sleep(60)
      end
    end

  end
end
