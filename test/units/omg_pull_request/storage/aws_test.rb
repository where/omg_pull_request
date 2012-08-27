require './test/test_helper.rb'

module OmgPullRequest
  module Storage
    class AwsTest  < MiniTest::Unit::TestCase
      def test_store
        FakeWeb.register_uri(:put, "http://s3.amazonaws.com/rofl/omg", :body => 'mmmkay')
        storage.store("omg", "omg")
      end

      protected

      def storage

        config = Configuration.new
        config.config = {
            'storage' => {
              'access_token' => 'omg', 
              'secret_token' => 'lol', 
              'bucket' => 'rofl'
            }
          }
        
        @store ||= Aws.new(
          :configuration => config
        )
      end
    end
  end
end
