module OmgPullRequest
  module TestRunner
    def self.start_daemon
      while(true)
        begin
          GITHUB_WRAPPER.pull_requests.each do |pr|
            runner = CONFIGURATION.runner_class.new(:configuration => CONFIGURATION, :pull_request  => pr)
            next if CONTEXT.ran?(runner.request_sha)
            CONTEXT.ran(runner.request_sha)

            runner.run
          end

        rescue => ex
          puts "An Error Occured: #{ex.inspect}\n#{ex.backtrace}"
        end

        sleep(60)
      end
    end
  end
end
