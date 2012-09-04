module OmgPullRequest
  class Configuration
    attr_accessor :config, :local_repo

    def initialize(attributes={})
      attributes.each do |attr, value|
        self.send("#{attr}=", value)
      end

      if config.blank? && File.exists?(self.config_file)
        @config = YAML.load(File.open(self.config_file))
      end
    end


    [:repo_owner, :repo, :database_yml, :aws, :github_credentials,
      :lolcommits_server_url, :prowl, :locale, :storage].each do |attr|
      define_method attr do
        self.config[attr.to_s]
      end
    end

    def local_repo
      @local_repo ||= (self.config['local_repo'] || Dir.pwd)
    end

    def database_yml
      self.config['database_yml'] || File.join(omg_dir, 'database.yml')
    end

    def config_file
      file = ENV['yml'] || File.join(omg_dir, 'config.yml')
      unless File.exist?(file)
        raise "Configuration file does not exist: #{file}"
      end

      file
    end

    def omg_dir
      File.join(local_repo, 'test/omg_pull_request')
    end

    def runner_class
      "OmgPullRequest::TestRunner::#{config['runner'] || 'Rails'}".constantize
    end

    def storage_class
      "OmgPullRequest::Storage::#{(config['storage'] || Hash.new)['provider'] || 'Gist'}".constantize
    end

    def initialize_localization!
      return if @initialized

      I18n.locale = self.locale if self.locale
      @initialized = true
    end

    module Helpers
      def delegate_config_to(config, *attrs)
        attrs.each do |attr|
          define_method attr do
            self.send(config).send(attr)
          end
        end
      end
    end
  end
end
