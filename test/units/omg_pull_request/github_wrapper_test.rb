require './test/test_helper.rb'

module OmgPullRequest
  class GithubWrapperTest < MiniTest::Unit::TestCase
    def test_flunk
      fakeweb_kenmazaika
      logins = github_wrapper.author_logins(MockPullRequest.new)
      assert_equal ["kenmazaika", "kenmazaika@gmail.com"], logins
    end

    def test_all_logins
      fakeweb_comments
      assert_equal ['kenmazaika', 'wherebot'], github_wrapper.all_logins(MockPullRequest.new)
    end

    def test_commit_shas
      fakeweb_get_pull_request_commits
      expected = ["c129a13a1c6", "dcc1e9847ff", "c204cee08e0", "ad0a65aeeca"]
      assert_equal expected, github_wrapper.commit_shas(MockPullRequest.new)
    end

    def test_make_comment
      fakeweb_create_comment
      github_wrapper.make_comment(MockPullRequest.new.number, "omg")
    end

    def test_pull_requests
      fakeweb_pull_requests
      prs = github_wrapper.pull_requests
      assert_equal 1, prs.count
      pr = prs.first
      assert_equal Hashie::Mash, pr.class
      assert_equal "Omg", pr.title 
    end

    protected

    def github_wrapper
      @github_wrapper ||= GithubWrapper.new(:configuration => CONFIGURATION)
    end
  end

end
