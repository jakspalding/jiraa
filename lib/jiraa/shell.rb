require 'bombshell'

module Jiraa
  class Shell < Bombshell::Environment
    include Bombshell::Shell

    prompt_with 'jiraa'

    before_launch do
      Jiraa::Configuration.init({})
    end

    def info
      Jiraa::Common.server_info
    end

    def version
      puts Jiraa::version
    end

    def current
      Jiraa::Common.current_issues
    end

    def search(jql)
      Jiraa::Common.search_issues(jql)
    end
  end
end