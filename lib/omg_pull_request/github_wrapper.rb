module OmgPullRequest
  class GithubWrapper
    attr_accessor :configuration

    def initialize(attributes={})
      attributes.each do |attr, value|
        self.send("#{attr}=", value)
      end
    end

    def author_logins(pull_request)
      [pull_request.user.login, github_client.users.get(:user => pull_request.user.login).email]
    end

    def all_logins(pull_request)
      logins = [pull_request.user.login]

      logins |= github_client.issues.comments.list(repo_owner, repo, pull_request.number).collect do |c| 
        c.user.login
      end

      logins.uniq
    end

    def commit_shas(pull_request)
      commits = github_client.pull_requests.commits(repo_owner, repo, pull_request.number)

      commits.collect do |commit| 
        commit.sha[0..10] 
      end
    end

    def make_comment(issue_number, body)
      github_client.issues.comments.create(repo_owner, repo, issue_number, :body => body)
    end

    def pull_requests
      github_client.pull_requests.list(repo_owner, repo)
    end

    def make_gist(data, file_name)
      gist = github_client.gists.create(
        'description' => 'Omg!  Pull Request!',
        'public' => false,
        'files' => {
          file_name => {
            'content' => data
          }
        }
      )

      gist.files[file_name].raw_url
    end

    private

    extend Configuration::Helpers
    delegate_config_to(:configuration, :repo_owner, :repo, :github_credentials)

    def github_client
      @github_client ||= Github.new(github_credentials.symbolize_keys)
    end
  end
end
