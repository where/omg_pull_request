require './test/test_helper.rb'

module OmgPullRequest
  module Storage
    class GistTest  < MiniTest::Unit::TestCase
      def test_store
        fakeweb_make_gist
        storage.store(StringIO.new("omg"), "file_name")
      end

      protected

      def storage
        @store ||= Gist.new(
          :configuration => MOCK_CONFIGURATION,
          :github_wrapper => MOCK_GITHUB_WRAPPER
        )
      end
    end
  end
end

