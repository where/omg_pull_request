require 'minitest/autorun'
require 'fakeweb'

ENV['yml'] = File.join(File.expand_path("..", __FILE__), "fixtures/config.yml")
require './lib/omg_pull_request'
require './test/mocks/pull_request'


OmgPullRequest::TestLogger.class_eval do
  def log(output)
    # NOOP on logging
  end
end

FakeWeb.allow_net_connect = false

def fakeweb_get_pull_request_commits
  FakeWeb.register_uri(:get,
    "https://omg:pull_request@api.github.com/repos/kenmazaika/pictures/pulls/10/commits",
    :response => File.expand_path('test/fixtures/github_commits'))
end
