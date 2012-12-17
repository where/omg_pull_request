require './test/test_helper.rb'

module OmgPullRequest
  class ContextTest < MiniTest::Unit::TestCase
    def test_get_recently_closed
      context = OmgPullRequest::Context.new

      prs = [
        MockPullRequest.new(:number => 2), 
        MockPullRequest.new(:number => 3), 
        MockPullRequest.new(:number => 4)
      ]

      assert_equal [], context.get_recently_closed(prs)

      prs = [
        MockPullRequest.new(:number => 2), 
        MockPullRequest.new(:number => 4),
        MockPullRequest.new(:number => 5)
      ]

      assert_equal ["3"], context.get_recently_closed(prs)

    end

  end
end
