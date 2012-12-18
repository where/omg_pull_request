require './test/test_helper.rb'

module OmgPullRequest
  class ConfigurationTest < MiniTest::Unit::TestCase
    def test_plugins
      conf = { 'plugins' => 'OmgPullRequest::ConfigurationTest::MockPlugin1,OmgPullRequest::ConfigurationTest::MockPlugin2' }

      configuration = OmgPullRequest::Configuration.new('config' => conf)
      plugins = configuration.plugins

      plugins.each do |plugin|
        assert_equal({:options => conf }.with_indifferent_access, plugin.attributes)
        assert_equal('mock_plugin_yeah', plugin.to_s)
      end
    end

    class MockPlugin1
      attr_accessor :attributes
      def initialize(attributes=Hash.new)
        self.attributes = attributes
      end

      def to_s
        "mock_plugin_yeah"
      end
    end

    class MockPlugin2
      attr_accessor :attributes
      def initialize(attributes=Hash.new)
        self.attributes = attributes
      end

      def to_s
        "mock_plugin_yeah"
      end
    end
  end
end
