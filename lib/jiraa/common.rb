require 'jira_client'

module Jiraa
  class Common
    def self.server_info
      info = ::JiraClient.server_info
      puts "Server: #{info.server_title}"
      puts "URL: #{info.base_url}"
      puts "Version: #{info.version}"
    end
  end
end