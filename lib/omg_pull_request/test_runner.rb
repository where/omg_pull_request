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

      Plugin.instrument("initialize", 
        :configuration  => configuration,
        :github_wrapper => github_wrapper
      )

      while(true)
        begin
          Plugin.instrument("execute", {})
          pull_requests = github_wrapper.pull_requests

          CONTEXT.get_recently_closed(pull_requests).each do |closed|
            pr = github_wrapper.find_pull_request(closed)
            event = pr.merged ? 'merged' : 'closed'
            Plugin.instrument(event, :pull_request => pr)
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
            
            Plugin.instrument("run", :pull_request => pr)
            runner.run
          end

        rescue => ex
          puts "An Error Occurred: #{ex.inspect}\n#{ex.backtrace.join "\n"}"
        end

        return if daemonize == false
        sleep(60)
      end
    end

  end
end
