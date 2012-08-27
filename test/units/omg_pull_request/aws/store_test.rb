require './test/test_helper.rb'

module OmgPullRequest
  module Aws
    class StoreTest  < MiniTest::Unit::TestCase
      def test_store
        FakeWeb.register_uri(:put, "http://s3.amazonaws.com/rofl/omg", :body => 'mmmkay')
        storage.store("omg", "omg")
      end

      protected

      def storage
        @store ||= Store.new(:storage_config => {
          :access_token => 'omg', 
          :secret_token => 'lol', 
          :bucket => 'rofl'
        })
      end
    end
  end
end
