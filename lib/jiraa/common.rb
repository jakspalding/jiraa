require 'jira_client'

module Jiraa
  class Common
    def self.server_info
      info = ::JiraClient.server_info
      puts "Server: #{info.server_title}"
      puts "URL: #{info.base_url}"
      puts "Version: #{info.version}"
    end

    def self.current_issues
      issues = JiraClient.find_issues(:jql => "assignee = currentUser() AND status = 'In Progress'", :fields => [:summary, :status, :issuetype, :assignee])
      formatter = Jiraa::Formatters::IssueList.new(issues)
      formatter.format
    end
  end
end