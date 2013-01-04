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

    def test_execute_merge_no_conflict_but_not_success
      git_client.expects(:execute_command).returns(["yolo", 100])
      assert_raises RuntimeError do
        git_client.merge!("swag")
      end
    end

    private

    def git_client
      @git_client ||= GitClient.new(:logger => TestLogger.new, 
        :configuration => MOCK_CONFIGURATION)
    end

  end
end
