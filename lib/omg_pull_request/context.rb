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

    def get_recently_closed(pull_requests)
      current_ids = pull_requests.collect { |a| a.number.to_s }
      closed  = (@active_pull_requests || Array.new) - current_ids
      @active_pull_requests = current_ids
      
      closed
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
