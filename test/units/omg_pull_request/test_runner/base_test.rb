require './test/test_helper.rb'

module OmgPullRequest
  module TestRunner
    class BaseTest  < MiniTest::Unit::TestCase
      def test_request_sha
        expected = "BASE_SHA:HEAD_SHA"
        assert_equal expected, runner.request_sha
      end

      def test_initialize
        # regardless of if success is told be true, it's false on initialize
        runner = Base.new(:success => true)
        assert_equal false, runner.success
        assert_equal false, runner.success?

        runner.success = true
        assert_equal true, runner.success
        assert_equal true, runner.success?
      end

      def test_runtime
        runner.runtime = 63.12345
        assert_equal 1, runner.runtime_minutes
        assert_equal 3.123, runner.runtime_seconds
      end

      def test_run_success
        runner.expects(:log_test_details!).once
        runner.expects(:make_comment_test_running!).once
        runner.expects(:make_status_test_running!).once
        runner.git_client.expects(:checkout!).once
        runner.git_client.expects(:merge!).once.returns(:success)
        runner.expects(:make_comment_conflict!).never
        runner.expects(:make_status_conflict!).never
        runner.expects(:process_output!).once

        runner.run
      end

      def test_run_conflict
        runner.expects(:log_test_details!).once
        runner.expects(:make_comment_test_running!).once
        runner.expects(:make_status_test_running!).once
        runner.git_client.expects(:checkout!).once
        runner.git_client.expects(:merge!).once.returns(:conflict)
        runner.expects(:make_comment_conflict!).once
        runner.expects(:make_status_conflict!).once
        runner.expects(:process_output!).never

        runner.run
      end


      protected

      def runner
        @runner ||= Base.new(:pull_request => MockPullRequest.new)
      end
    end
  end
end
