module OmgPullRequest
  module TestRunner
    class Ruby < TestRunner::Base
      def execute_tests
        return execute!("cd #{local_repo} && rake")
      end
    end
  end
end
