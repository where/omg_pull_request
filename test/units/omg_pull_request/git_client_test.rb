require './test/test_helper.rb'

module OmgPullRequest
  class GitClientTest < MiniTest::Unit::TestCase
    
    def test_execute_verify_success
      assert_raises RuntimeError do
        git_client.send(:execute_verify_success, 'git omg lol 2>&1')
      end

      git_client.expects(:log).twice
      resp = git_client.send(:execute_verify_success, 'git --version')
      assert resp.match(/git/)
      git_client.unstub(:log)
    end

    private

    def git_client
      @git_client ||= GitClient.new(:logger => TestLogger.new)
    end

  end
end
