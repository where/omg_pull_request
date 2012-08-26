module OmgPullRequest
  class Context
    def ran(request_sha)
      ran_hash[request_sha] = true
    end

    def ran?(request_sha)
      ran_hash[request_sha] == true
    end

    def get_animated_shas(issue_number)
      animated_shas[issue_number] || []
    end

    def add_animated_shas(issue_number, shas)
      animated_shas[issue_number] = get_animated_shas(issue_number) + shas
    end

    private

    def ran_hash
      @ran_hash ||= Hash.new 
    end

    def animated_shas
      @animated_sha || Hash.new
    end
  end
end
