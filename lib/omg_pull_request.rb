require "rubygems"
require "bundler/setup"
require 'active_support/all'
require 'faraday'
require 'github_api'
require 'yaml'
require 'uuid'
require 'aws/s3'
require 'i18n'
require './lib/omg_pull_request/configuration'
require './lib/omg_pull_request/test_logger'
require './lib/omg_pull_request/aws/store'
require './lib/omg_pull_request/github_wrapper'
require './lib/omg_pull_request/notifications'
require './lib/omg_pull_request/test_runner'
require './lib/omg_pull_request/test_runner/base'
require './lib/omg_pull_request/test_runner/rails'
require './lib/omg_pull_request/context'
require './lib/omg_pull_request/git_client'
require './lib/omg_pull_request/prowl'
require './lib/omg_pull_request/lolcommits'
require './lib/omg_pull_request/version'

module OmgPullRequest
  CONFIGURATION     = Configuration.new
  STORE             = Aws::Store.new(:storage_config => CONFIGURATION.aws.symbolize_keys)
  CONTEXT           = Context.new
  GITHUB_WRAPPER    = GithubWrapper.new(:configuration => CONFIGURATION)
end


