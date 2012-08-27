require 'minitest/autorun'
require 'fakeweb'
require 'mocha'

ENV['yml'] = File.join(File.expand_path("..", __FILE__), "fixtures/config.yml")
require './lib/omg_pull_request'
require './test/mocks/pull_request'
require './test/mocks/git_client'

locale_dir = File.expand_path("../../locales", __FILE__)
I18n.load_path = [
  File.join(locale_dir, "omg.yml"),
  File.join(locale_dir, "en.yml")
]

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


def fakeweb_kenmazaika
  FakeWeb.register_uri(:get,
    "https://omg:pull_request@api.github.com/users/kenmazaika",
    :response => File.expand_path('test/fixtures/kenmazaika'))
end

def fakeweb_comments
  FakeWeb.register_uri(:get,
    "https://omg:pull_request@api.github.com/repos/kenmazaika/pictures/issues/10/comments",
    :response => File.expand_path('test/fixtures/comments'))
end

def fakeweb_create_comment
  FakeWeb.register_uri(:post,
    "https://omg:pull_request@api.github.com/repos/kenmazaika/pictures/issues/10/comments",
    :response => File.expand_path('test/fixtures/create_comment'))
end

def fakeweb_pull_requests
  FakeWeb.register_uri(:get,
    "https://omg:pull_request@api.github.com/repos/kenmazaika/pictures/pulls",
    :response => File.expand_path('test/fixtures/pull_requests'))
end
