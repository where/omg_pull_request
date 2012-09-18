require './test/test_helper.rb'

module OmgPullRequest
  class NotificationsTest  < MiniTest::Unit::TestCase
    def test_runner_hash
      expected = {
        :omg           => "omg", 
        :abbr_from_sha => "abbr_from_sha", 
        :abbr_to_sha   => "abbr_to_sha", 
        :minutes       => 1, 
        :seconds       => 3.45, 
        :issue_number  => 10, 
        :title         => "Omg"
      }

      assert_equal expected, mock_runner.send(:runner_hash, {:omg => 'omg'})
    end

    def test_github_comment
      fakeweb_create_comment
      mock_runner.send(:github_comment, "omg")
    end

    def test_prowl_alert_failure
      mock_runner.prowl_client.expects(:alert_author!).with(
        "Sad face to the max, homie.\nPull request #10\nOmg\nTests took 1 minutes, 3.45 seconds.",
        :failure
      ) 
      mock_runner.send(:prowl_alert_failure!)
    end

    def test_prowl_alert_success
      mock_runner.prowl_client.expects(:alert_all_relevant_people!).with(
        "Thumbs up, bro.\nPull request #10\nOmg\nTests took 1 minutes, 3.45 seconds.", 
        :success
      ) 
      mock_runner.send(:prowl_alert_success!)
    end

    def test_make_comment_test_running
      mock_runner.expects(:github_comment).with(
        ":trollface: Running tests: `abbr_from_sha` to `abbr_to_sha`\n\nThis is what hard work looks like\n![Pretty Pictures](http://lolcommits.com/omg)"
      )
      mock_runner.send(:make_comment_test_running!)
    end

    def test_make_comment_conflict
      mock_runner.expects(:github_comment).with(
        "### Unable To Run  \nA conflict prevented the test suite from being run.  Please manually resolve the conflict and the tests will be rerun.\nFrom `abbr_from_sha` to `abbr_to_sha`"
      )

      mock_runner.send(:make_comment_conflict!)
    end

    def test_make_comment_failure
      mock_runner.expects(:github_comment).with(
        ":thumbsdown: :fire: :broken_heart: \n### Tests Failed \n `abbr_from_sha` to `abbr_to_sha`\nTests too 1 minutes, 3.45 seconds.\n[results](url)"
      )
      mock_runner.send(:make_comment_failure!, "url")
    end

    def test_make_comment_success
      mock_runner.expects(:github_comment).with(
        ":thumbsup: :shipit: \n### Tests Passed  \nFrom `abbr_from_sha` to `abbr_to_sha`\nTests took 1 minutes, 3.45 seconds.\n[results](url)"
      )
      mock_runner.send(:make_comment_success!, "url")
    end

    protected

    def mock_runner
      @mock_runner ||= MockRunner.new
    end

  end

  class MockRunner
    include Notifications

    def github_wrapper
      MOCK_GITHUB_WRAPPER
    end

    def abbr_from_sha
      "abbr_from_sha"
    end

    def abbr_to_sha
      "abbr_to_sha"
    end

    def runtime_minutes
      1
    end

    def runtime_seconds
      3.45
    end

    def issue_number
      pull_request.number
    end

    def pull_request
      @pr ||= MockPullRequest.new
    end

    def prowl_client
      @prowl ||= Prowl.new
    end

    def t(key, options={})
      I18n.t(key, options)
    end

    def lolcommits_client
      MockLolcommits.new
    end

    def log(omg)
    end

    class MockLolcommits
      def animation_url
        "http://lolcommits.com/omg"
      end
    end
  end
end
