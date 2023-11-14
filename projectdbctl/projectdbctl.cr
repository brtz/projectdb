require "admiral"
require "./common"
require "./resource"
require "./user"

class Projectdbctl < Admiral::Command
  define_help description: "projectdbctl"

  class User < Admiral::Command
    define_help description: "User related commands"

    class Auth < Admiral::Command
      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          api_username = ENV["PROJECTDBCTL_API_USERNAME"]
          api_password = ENV["PROJECTDBCTL_API_PASSWORD"]
          ModUser.auth(api_url, api_username, api_password)
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    register_sub_command(auth, Auth)

    def run
      puts help
    end
  end

  class Project < Admiral::Command
    define_help description: "Project related commands"

    class List < Admiral::Command
      define_flag filters : Array(String), description: "Filters. Can be specified multiple times. Combined by &. e.g. name:*foo*", short: f, long: filter

      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          ModResource.list("projects", api_url, flags.filters)
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    register_sub_command(list, List)

    def run
      puts help
    end
  end

  register_sub_command(user, User)
  register_sub_command(project, Project)

  def run
    puts help
  end
end

Projectdbctl.run()
