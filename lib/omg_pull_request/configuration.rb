module OmgPullRequest
  class Configuration
    attr_reader   :config

    def initialize(attributes={})
      attributes.each do |attr, value|
        self.send("#{attr}=", value)
      end
      self.config_file ||= 'campaign_manager.yml'
      @config = YAML.load(File.open(self.config_file))
    end


    [:repo_owner, :repo, :database_yml, :aws, :github_credentials,
      :lolcommits_server_url, :prowl, :locale].each do |attr|
      define_method attr do
        self.config[attr.to_s]
      end
    end

    def local_repo
      self.config['local_repo'] || Dir.pwd
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
      File.join(Dir.pwd, 'test/omg_pull_request')
    end

    def runner_class
      "OmgPullRequest::TestRunner::#{config['runner'] || 'Rails'}".constantize
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
