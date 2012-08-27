module OmgPullRequest
  module Storage
    class Gist
      attr_accessor :configuration, :github_wrapper

      def initialize(attributes={})
        attributes.each do |attr, value|
          self.send("#{attr}=", value)
        end
      end

      # TODO test
      def store(data, file_name)
        self.github_wrapper.make_gist(data, file_name)
      end
    end

  end
end
