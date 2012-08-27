require "minitest/autorun"
require 'yaml'
require './lib/omg_pull_request'

locale_dir = File.expand_path("../../../locales", __FILE__)
I18n.load_path = [
  File.join(locale_dir, "omg.yml"),
  File.join(locale_dir, "en.yml")
]

class RunnerTest < MiniTest::Unit::TestCase
  # SHHHH
  OmgPullRequest::TestLogger.class_eval do
    def puts(msg); end
  end
  OmgPullRequest::TestRunner::Base.class_eval do
    def puts(msg); end
  end

  def setup
    if Dir.exists?("#{stage_dir}/omg")
      `cd #{stage_dir} && git fetch > /dev/null 2>&1`
    else
      `cd #{stage_dir} && git clone https://github.com/#{config[:login]}/omg.git`
    end

    repo = github.repos.get(config[:login], "omg") rescue nil

    unless repo
      github.repos.forks.create('wherebot', 'omg')
      sleep(10)
      repo = github.repos.get(config[:login], "omg") 
    end

    prs = github.pull_requests.list(config[:login], "omg")

    prs.each do |pr|
      github.pull_requests.update config[:login], 'omg', pr.number, :state => 'closed'
    end

  end

  def test_success
    github.pull_requests.create config[:login], 'omg',
        "head" => "#{config[:login]}:success",
        "base" => "master",
        "title" => 'Success'
    
    prs = github.pull_requests.list(config[:login], "omg")
    assert_equal 1, prs.count
    pr = prs.first

    runner = build_runner(pr)
    
    runner.run

    posts = github.issues.comments.list(config[:login], 'omg', pr.number)
    assert_equal 2, posts.count
    running = posts.first
    pass = posts.last

    assert running['body'].match(/Running tests/)
    assert pass['body'].match(/Tests Passed/)
  end

  # TODO: fail test
  # TODO: conflict test

  protected

  def build_runner(pull_request)
    configuration = {"repo_owner"=>config[:login],
      "repo"=>"omg",
      "locale"=>"en", 
      "local_repo" => "#{stage_dir}/omg",
      "database_yml" => "#{stage_dir}/database.yml",
      "runner"=>"Ruby", 
      "github_credentials"=>{
          "login"=>config[:login], 
          "password"=>config[:password]
      }, 
      "prowl"=>{
            "application"=>"wherebot", 
            "keys"=>{
              "kenmazaika"=>"omg", 
              "kenmazaika@gmail.com"=>"omg"
            }
        }
    }

    OmgPullRequest::CONFIGURATION.config = configuration
    OmgPullRequest::TestRunner::Rails.new(
      :configuration => OmgPullRequest::CONFIGURATION,
      :pull_request  => pull_request
    )
  end

  def stage_dir
    @stage_dir ||= File.expand_path("../.stage", __FILE__)
  end

  def github
    @github ||= Github.new(config)
  end

  def config
    @config ||= YAML.load(File.open("./test/integrations/config.yml"))
  end

end
