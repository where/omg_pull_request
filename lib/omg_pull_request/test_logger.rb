module OmgPullRequest
  class TestLogger
    attr_accessor :store, :buffer
    def initialize(attributes={})
      attributes.each do |attr, value|
        self.send("#{attr}=", value)
      end
    end

    def log(output)
      puts output
      self.buffer = "#{buffer}\n#{output}"
    end

    def store_logs!(file_name)
      self.store.store(StringIO.new(buffer), file_name)
    end

  end
end
