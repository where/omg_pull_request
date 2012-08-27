require "rubygems"
require "bundler/setup"
require 'active_support/all'
require 'faraday'
require 'github_api'
require 'yaml'
require 'uuid'
require 'aws/s3'
require 'i18n'
require 'omg_pull_request/configuration'
require 'omg_pull_request/test_logger'
require 'omg_pull_request/aws/store'
require 'omg_pull_request/github_wrapper'
require 'omg_pull_request/notifications'
require 'omg_pull_request/test_runner'
require 'omg_pull_request/test_runner/base'
require 'omg_pull_request/test_runner/rails'
require 'omg_pull_request/test_runner/ruby'
require 'omg_pull_request/context'
require 'omg_pull_request/git_client'
require 'omg_pull_request/prowl'
require 'omg_pull_request/lolcommits'
require 'omg_pull_request/version'

module OmgPullRequest
  CONFIGURATION     = Configuration.new
  STORE             = Aws::Store.new(:storage_config => CONFIGURATION.aws.symbolize_keys)
  CONTEXT           = Context.new
  GITHUB_WRAPPER    = GithubWrapper.new(:configuration => CONFIGURATION)
end


