module OmgPullRequest
  class GitClient
    attr_accessor :logger, :configuration

    def initialize(attributes=Hash.new)
      attributes.each do |attr, value|
        self.send("#{attr}=", value)
      end
    end

    def committers(from_sha, to_sha)
      `cd #{local_repo} && git shortlog -sne #{from_sha}..#{to_sha} | awk '{ print $NF}' | cut -d'<' -f2 | cut -d'>' -f1`.split
    end

    def checkout!(sha)
      logger.log `cd #{local_repo} && git reset --hard && git fetch && git checkout #{sha}`
    end

    def merge!(sha)
      merge_response = `cd #{local_repo} && git merge #{sha}`
      self.logger.log merge_response
      merge_response.match(/CONFLICT/) ? :conflict : :success
    end


    private

    extend Configuration::Helpers
    delegate_config_to(:configuration, :local_repo)
  end
end
