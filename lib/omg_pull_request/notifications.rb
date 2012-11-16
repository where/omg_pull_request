module OmgPullRequest
  module Notifications
    protected
    # GITHUB
    def make_comment_success!(output_file)
      github_comment(t("completed.github.success", runner_hash(:output_file => output_file)))
    end

    def make_comment_failure!(output_file)
      github_comment(t("completed.github.failure", runner_hash(:output_file => output_file)))
    end

    def make_comment_conflict!
      github_comment(t("error.github.conflict", runner_hash))
      self.log(t("error.github.conflict", runner_hash)) 
    end

    def make_comment_test_running!
      lol_url = lolcommits_client.animation_url
      message = t("start.github.message", runner_hash)
      message = t("start.github.lolcommits.message", runner_hash(:animation_url => lol_url)) if lol_url
      github_comment(message)
    end

    #GITHUB STATUS
    def make_status_success!(output_file)
      github_status(
        GithubWrapper::STATUSES[:success],
        :target_url => output_file,
        :description => t("completed.github_status.success", runner_hash)
      )
    end

    def make_status_failure!(output_file)
      github_status(
        GithubWrapper::STATUSES[:failure],
        :target_url => output_file,
        :description => t("completed.github_status.failure", runner_hash)
      )
    end

    def make_status_conflict!
      github_status(
        GithubWrapper::STATUSES[:conflict],
        :description => t("error.github_status.conflict", runner_hash)
      )
    end

    def make_status_test_running!
      github_status(
        GithubWrapper::STATUSES[:pending],
        :description => t("start.github_status.message", runner_hash)
      )
    end

    # PROWL
    def prowl_alert_success!
      message = t("completed.prowl.success", runner_hash)
      self.prowl_client.alert_all_relevant_people!(message, :success)
    end

    def prowl_alert_failure!
      message = t("completed.prowl.failure", runner_hash)
      self.prowl_client.alert_author!(message, :failure)
    end


    def process_output!
      output_file = store_logger_data!
      if self.success?
        make_comment_success!(output_file)
        make_status_success!(output_file)
        prowl_alert_success!
      else
        make_comment_failure!(output_file)
        make_status_failure!(output_file)
        prowl_alert_failure!
      end
    end

    def github_comment(message)
      self.github_wrapper.create_comment(self.issue_number, message)
    end

    def github_status(status, params={})
      self.github_wrapper.create_status(self.to_sha, status, params)
    end

    def runner_hash(also=Hash.new)
      also.merge({
        :abbr_from_sha => abbr_from_sha,
        :abbr_to_sha   => abbr_to_sha,
        :minutes       => runtime_minutes,
        :seconds       => runtime_seconds,
        :issue_number  => issue_number,
        :title         => pull_request.title
      })
    end

    public

  end
end
