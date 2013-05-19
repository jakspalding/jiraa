require 'yaml'
require 'jira_client'

module Jiraa
  class Configuration
    @config = {}

    def self.init(global_config)
      instance = self.new
      config = instance.load_config(global_config)
      configure_client(config)
      config
    end

    def self.configure_client(config)
      JiraClient.configure do |c|
        c.base_url = config["url"]
        c.certificate = config["certificate"]
        c.username = config["username"]
        c.password = config["password"]
        c.port = config["port"]
        c.proxy = ENV['https_proxy']
      end
    end

    def load_config(global_config)
      filename = File.join(ENV['HOME'], ".jiraa")
      if File.exists?(filename)
        read_config_file(filename)
      else
        create_config_file(filename, global_config)
      end

      @config.merge! global_config
    end

    private

      def read_config_file(filename)
        @config = YAML.load_file(filename) || {}
      end

      def create_config_file(filename, config)
        url = config[:url] || "https://jira.example.com"
        username = config[:username] || "username"
        password = config[:password] || "password"
        certificate = config[:certificate] || "/usr/local/certificates/my_cert.pem"
        File.open(filename, 'w') do |file|
          file.write <<-EOF
---
# Enter the URL of your Jira instance here:
#{'#' unless config[:url]}url: #{url}

# If your Jira server uses HTTP basic authentication then fill in your username and password:
#{'#' unless config[:username]}username: #{username}
#{'#' unless config[:password]}password: #{password}

# If your Jira server users SSL certificate authentication then provide a path to your certificate:
#{'#' unless config[:certificate]}certificate: #{certificate}
EOF
          {}
        end
      end

  end
end