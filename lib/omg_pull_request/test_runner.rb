module OmgPullRequest
  module TestRunner

    def self.start_daemon(configuration=Configuration.new, daemonize=true)
      github_wrapper    = GithubWrapper.new(
        :configuration => configuration
      )

      store = configuration.storage_class.new(
        :configuration => configuration,
        :github_wrapper => github_wrapper
      )

      plugins = configuration.plugins

      while(true)
        begin
          pull_requests   = github_wrapper.pull_requests
          closed_requests = CONTEXT.get_recently_closed(pull_requests)
          closed_requests.each do |closed|
            pr = github_wrapper.find_pull_request(closed)
            merged = pr.merged 

            plugins.each do |plugin|
              if merged && plugin.respond_to?(:pull_request_merged)
                plugin.pull_request_merged(pr)
              elsif !merged && plugin.respond_to?(:pull_request_closed)
                plugin.pull_request_closed(pr)
              end
            end
          end

          pull_requests.each do |pr|
            runner = configuration.runner_class.new(
              :configuration  => configuration, 
              :pull_request   => pr, 
              :github_wrapper => github_wrapper,
              :store          => store
            )
            next if CONTEXT.ran?(runner.request_sha)
            CONTEXT.ran(runner.request_sha)

            plugins.each do |plugin|
              if plugin.respond_to?(:test_run)
                plugin.test_run(pr)
              end
            end

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
