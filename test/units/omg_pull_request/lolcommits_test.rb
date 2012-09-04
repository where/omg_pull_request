require './test/test_helper.rb'

module OmgPullRequest
  class LolcommitsTest < MiniTest::Unit::TestCase
    def setup
      fakeweb_get_pull_request_commits
    end

    def test_get_animation_url_success
      shas = ['lol', 'rofl']

      url = fakeweb_create_animation

      assert_equal url, lolcommits_client.send(:get_animation_url, shas)
    end

    def test_get_animation_url_no_animations
      assert_nil lolcommits_client.send(:get_animation_url, [])
      assert_nil lolcommits_client.send(:get_animation_url, nil)
    end

    def test_animation_url
      expected_url = fakeweb_create_animation
      returned_url = lolcommits_client.animation_url
      assert_equal expected_url, returned_url
    end


    private

    def fakeweb_create_animation
      url = "http://lolcommits.com/omg"
      FakeWeb.register_uri(:post, "#{Lolcommits::LOLCOMMITS_URL}#{Lolcommits::LOLCOMMITS_PATH}", :body => {:image => {:url => url} }.to_json)
      url
    end

    def lolcommits_client
      @lolcommits_client ||= Lolcommits.new(:context => CONTEXT, :github_wrapper => MOCK_GITHUB_WRAPPER,
        :runner => TestRunner::Base.new(:pull_request => MockPullRequest.new))
    end
  end
end
