require './test/test_helper.rb'

module OmgPullRequest
  class ProwlTest < MiniTest::Unit::TestCase
    def test_notify_users
      message = "omg"
      keys = ['lol', 'rofl']

      FakeWeb.register_uri(:post, "#{Prowl::PROWL_URL}#{Prowl::PROWL_PATH}", :body => "OK")

      prowl_client.notify_users(message, keys) 
    end

    def test_keys_for_users
      assert_equal ['OMG_OMG'],
        prowl_client.send(:keys_for_users, ['kenmazaika','kenmazaika@gmail.com', 'omg'])
    end

    def test_alert_author
      fakeweb_kenmazaika

      prowl_client.expects(:notify_users).with(
        'omg', ['OMG_OMG'], 
        {:url => 'http://omg.com/html_url', :event => :success}
      )

      prowl_client.alert_author!("omg", :success)
    end

    def test_alert_all_relevant_people
      fakeweb_comments

      prowl_client.expects(:notify_users).with(
        'omg', ['OMG_OMG', "REG_DUDE"], 
        {:url => 'http://omg.com/html_url', :event => :failure}
      )

      prowl_client.alert_all_relevant_people!("omg", :failure)
    end

    private

    def prowl_client
      runner = TestRunner::Base.new(:pull_request => MockPullRequest.new)
      runner.expects(:git_client).returns(MockGitClient.new).at_least(0)
      @prowl_client ||= OmgPullRequest::Prowl.new(:configuration => CONFIGURATION,
        :runner => runner,
        :github_wrapper => GITHUB_WRAPPER)
    end
  end
end
