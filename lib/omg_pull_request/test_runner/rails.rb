module OmgPullRequest
  module TestRunner
    class Rails < TestRunner::Base
      def setup
        execute!("cd #{local_repo} && cp #{database_yml} config/database.yml && bundle")
        execute!("cd #{local_repo} && bundle exec rake db:drop:all && rake db:create:all && bundle exec rake db:schema:load")
      end

      def execute_tests
        return execute!("cd #{local_repo} && bundle exec rake")
      end

      def teardown
        execute!("rm #{local_repo}/log/test.log")
      end

    end
  end
end
