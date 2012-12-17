class MockPullRequest
  def initialize(attributes={})
    default_attributes = {
      :number   => 10,
      :user     => MockUser.new,
      :title    => "Omg",
      :html_url => "http://omg.com/html_url",
      :head     => MockSha.new("HEAD_SHA"),
      :base     => MockSha.new("BASE_SHA")
    }
    @attributes = default_attributes.merge(attributes)
  end

  [:number, :user, :title, :html_url, :head, :base].each do |field|
    define_method field do
      @attributes[field]
    end
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
