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
      execute_verify_success "cd #{local_repo} && git reset --hard && git clean -f -d && git fetch && git checkout #{sha} 2>&1"
    end

    def merge!(sha)
      merge_response, exit_code = execute_command "cd #{local_repo} && git merge #{sha} 2>&1"
      self.logger.log merge_response
      return :success if exit_code.zero?
      return :conflict if merge_response.match(/CONFLICT/)
      
      raise "Boom goes the dynamite!  Failure to do the merge in a non-predicatable way."
    end

    private

    def execute_command(command)
      resp = `#{command}`
      [resp, $?.to_i]
    end

    def execute_verify_success(command)
      result = `#{command}`
      logger.log(command) 
      logger.log(result)
      exit_code = $?.to_i
      raise "Not a successful response code: #{exit_code}" unless exit_code.zero?
      result
    end

    extend Configuration::Helpers
    delegate_config_to(:configuration, :local_repo)
  end
end
