require 'minitest/autorun'
require 'fakeweb'

ENV['yml'] = File.join(File.expand_path("..", __FILE__), "fixtures/config.yml")
require './lib/omg_pull_request'


OmgPullRequest::TestLogger.class_eval do
  def log(output)
    # NOOP on logging
  end
end

FakeWeb.allow_net_connect = false
