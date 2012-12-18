require 'singleton'

module OmgPullRequest
  class Plugin
    def self.initialize(&block)
      ActiveSupport::Notifications.subscribe("omgpr:initialize") do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)
        block.call(event.payload)
      end
    end

    def self.subscribe(method, &block)
      ActiveSupport::Notifications.subscribe("omgpr:#{method}") do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)
        block.call(event.payload)
      end
    end

    def self.instrument(event, args)
      Plugin::Instrumenter.instance.instrument(event, args)
    end

    class Instrumenter
      include Singleton

      def initialize
        Plugin.initialize do |attributes|
          @attributes = attributes
        end
      end

      def instrument(event, args)
        ActiveSupport::Notifications.instrument("omgpr:#{event}", (@attributes || {}).merge(args))
      end
    end
  end
end
