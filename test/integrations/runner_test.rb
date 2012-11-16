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
   repo = github.repos.get(config[:login], "omg") rescue nil

    unless repo
      github.repos.forks.create('wherebot', 'omg')
      sleep(10)
      repo = github.repos.get(config[:login], "omg") 
    end

    if Dir.exists?("#{stage_dir}/omg")
      `cd #{stage_dir} && git fetch > /dev/null 2>&1`
    else
      `cd #{stage_dir} && git clone https://github.com/#{config[:login]}/omg.git`
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
    statuses = github.repos.statuses.list(config[:login], 'omg', pr.head.sha)
    assert_equal 2, posts.count
    assert_equal "success", statuses.first.state
    running = posts.first
    pass = posts.last

    assert running['body'].match(/Running tests/)
    assert pass['body'].match(/Tests Passed/)
  end

  def test_pending
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
    statuses = github.repos.statuses.list(config[:login], 'omg', pr.head.sha)
    assert_equal 2, posts.count
    assert_equal "pending", statuses.at(1).state
    running = posts.first
    pass = posts.last

    assert running['body'].match(/Running tests/)
    assert pass['body'].match(/Tests Passed/)
  end

  def test_failure
    github.pull_requests.create config[:login], 'omg',
        "head" => "#{config[:login]}:failure",
        "base" => "master",
        "title" => 'Failure'
    
    prs = github.pull_requests.list(config[:login], "omg")
    assert_equal 1, prs.count
    pr = prs.first

    runner = build_runner(pr)
    
    runner.run

    posts = github.issues.comments.list(config[:login], 'omg', pr.number)
    statuses = github.repos.statuses.list(config[:login], 'omg', pr.head.sha)
    assert_equal 2, posts.count
    assert_equal "failure", statuses.first.state
    running = posts.first
    pass = posts.last

    assert running['body'].match(/Running tests/)
    assert pass['body'].match(/Tests Fail/)
  end

  def test_conflict
    github.pull_requests.create config[:login], 'omg',
        "head" => "#{config[:login]}:conflict",
        "base" => "master",
        "title" => 'Conflict'
    
    prs = github.pull_requests.list(config[:login], "omg")
    assert_equal 1, prs.count
    pr = prs.first

    runner = build_runner(pr)
    
    runner.run

    posts = github.issues.comments.list(config[:login], 'omg', pr.number)
    statuses = github.repos.statuses.list(config[:login], 'omg', pr.head.sha)
    assert_equal 2, posts.count
    assert_equal "error", statuses.first.state
    running = posts.first
    conflict = posts.last

    assert running['body'].match(/Running tests/)
    assert conflict['body'].match(/conflict/)
  end

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
    config = OmgPullRequest::Configuration.new(:config => configuration)

    github_wrapper = OmgPullRequest::GithubWrapper.new(
      :configuration => config
    )
    store = config.storage_class.new(
      :configuration  => config,
      :github_wrapper => github_wrapper
    )

    OmgPullRequest::TestRunner::Rails.new(
      :github_wrapper => github_wrapper,
      :configuration  => config,
      :pull_request   => pull_request,
      :store          => store
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
