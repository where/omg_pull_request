module OmgPullRequest
  class Lolcommits
    LOLCOMMITS_PATH = '/animated_gifs'
    LOLCOMMITS_URL = "http://www.lolcommits.com"
    attr_accessor :configuration, :github_wrapper, :runner, :context

    def initialize(attributes=Hash.new)
      attributes.each do |attr, value|
        self.send("#{attr}=", value)
      end
    end

    def animation_url
      return @animation_url if @animation_url
      commits = GITHUB_WRAPPER.commit_shas(runner.pull_request) - 
        CONTEXT.get_animated_shas(runner.pull_request.number)
      CONTEXT.add_animated_shas(runner.pull_request.number, commits)

      @animation_url ||= get_animation_url(commits)
    end

    protected

    def get_animation_url(shas)
      if shas.any?
        response = lolcommits_connection.post LOLCOMMITS_PATH, :animated_gif => { :shas => shas.join(',') }
        JSON.parse(response.body).fetch("image").fetch("url") if response.status == 200
      end
    end

    def lolcommits_connection
      @lolcommits_connection ||= Faraday.new(:url => LOLCOMMITS_URL) do |f|
        f.request  :url_encoded
        f.adapter  Faraday.default_adapter
      end
    end

  end
end
