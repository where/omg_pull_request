require 'minitest/autorun'
require 'fakeweb'
# TODO: make a specific test one, instead of using this file
ENV['yml'] = './testing.yml'
require './lib/omg_pull_request'

OmgPullRequest::LOGGER.instance_eval do
  def log(output)
    # NOOP on logging
  end
end


FakeWeb.allow_net_connect = false
