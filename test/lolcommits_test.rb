require './test/test_helper.rb'

class LolcommitsTest < MiniTest::Unit::TestCase
  def test_get_animation_url
    shas = ['lol', 'rofl']
    url = "http://lolcommits.com/omg"

    FakeWeb.register_uri(:post, "#{OmgPullRequest::Lolcommits::LOLCOMMITS_URL}#{OmgPullRequest::Lolcommits::LOLCOMMITS_PATH}", :body => {:image => {:url => url} }.to_json)
    
    assert_equal url, lolcommits_client.send(:get_animation_url, shas)
  end

  private

  def lolcommits_client
    @lolcommits_client ||= OmgPullRequest::Lolcommits.new
  end
end


