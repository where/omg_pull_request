require './test/test_helper.rb'

module OmgPullRequest
  class GithubWrapperTest < MiniTest::Unit::TestCase
    def test_author_logins
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

    def test_create_comment
      fakeweb_create_comment
      github_wrapper.create_comment(MockPullRequest.new.number, "omg")
    end

    def test_create_status
      fakeweb_create_status
      github_wrapper.create_status(MockPullRequest.new.head.sha, "success")
    end

    def test_get_statuses
      fakeweb_get_statuses
      expected = [ "state" => "success" ]
      assert_equal expected, github_wrapper.get_statuses(MockPullRequest.new.head.sha)
    end

    def test_pull_requests
      fakeweb_pull_requests
      prs = github_wrapper.pull_requests
      assert_equal 1, prs.count
      pr = prs.first
      assert_equal Hashie::Mash, pr.class
      assert_equal "Omg", pr.title 
    end

    def test_make_gist
      fakeweb_make_gist
      expected_url = "https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/file_name"
      assert_equal expected_url, github_wrapper.make_gist("omg", "file_name")
    end

    protected

    def github_wrapper
      @github_wrapper ||= GithubWrapper.new(:configuration => MOCK_CONFIGURATION)
    end
  end

end
