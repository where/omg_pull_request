module OmgPullRequest
  class Prowl
    PROWL_URL       = 'https://api.prowlapp.com'
    PROWL_PATH      = '/publicapi/add'

    attr_accessor :configuration, :logger, :runner, :github_wrapper

    def initialize(attributes=Hash.new)
      attributes.each do |attr, value|
        self.send("#{attr}=", value)
      end
    end

    def notify_users(msg, keys=[], options={})
      return if keys.blank?

      opts = {
        :application => prowl_application,
        :event => "notification",
        :description => msg
      }.merge( options )

      keys.each do |key|
        open_connection.post PROWL_PATH, opts.merge(:apikey => key)
      end
    end

    def alert_all_relevant_people!(message, event)
      notify_users(message, all_keys, { 
        :url   => runner.pull_request.html_url, 
        :event => event
      } )
    end

    def alert_author!(message, event)
      notify_users(message, author_keys, {
        :url   => runner.pull_request.html_url,
        :event => event
      })
    end

    private

    def keys_for_users(users=[])
      users.collect { |u| (prowl_keys || {})[u] }.compact.uniq
    end

    def author_keys
      author_logins = github_wrapper.author_logins(runner.pull_request)
      keys_for_users(author_logins)
    end

    def all_keys
      logins = github_wrapper.all_logins(runner.pull_request) + 
        runner.git_client.committers(runner.from_sha, runner.to_sha) 

      keys_for_users(logins)
    end

    def open_connection
      @open_connection ||= Faraday.new(:url => PROWL_URL) do |f|
        f.request  :url_encoded
        f.adapter  Faraday.default_adapter
      end
    end

    extend Configuration::Helpers
    delegate_config_to(:configuration, :prowl)

    [:application, :keys].each do |attr|
      define_method "prowl_#{attr}" do
        (prowl || Hash.new)[attr.to_s]
      end
    end

  end
end
