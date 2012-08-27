class MockPullRequest
  def number
    10
  end

  def user
    MockUser.new
  end

  def html_url
    "http://omg.com/html_url"
  end

  def head
    MockSha.new("HEAD_SHA")
  end

  def base
    MockSha.new("BASE_SHA")
  end

  class MockUser
    def login
      "kenmazaika"
    end
  end

  class MockSha
    attr_reader :sha
    def initialize(sha)
      @sha = sha
    end
  end
end
