require './test/test_helper.rb'
class ProwlTest < MiniTest::Unit::TestCase
  def test_notify_users
    message = "omg"
    keys = ['lol', 'rofl']

    FakeWeb.register_uri(:post, "#{Prowl::PROWL_URL}#{Prowl::PROWL_PATH}", :body => "OK")
    
    prowl_client.notify_users(message, keys) 
  end

  def test_keys_for_users
    assert_equal ['3d462dad6d239914a39da71af2e98ab15d5c19e6'],
      prowl_client.keys_for_users(['kenmazaika','kenmazaika@gmail.com', 'omg'])
  end

  private

  def prowl_client
    @prowl_client ||= Prowl.new
  end
end


