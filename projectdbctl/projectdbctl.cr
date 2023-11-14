require "admiral"

require "./user"
require "./resource"

class Projectdbctl < Admiral::Command
  define_help description: "projectdbctl"

  class User < Admiral::Command
    define_help description: "User"

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

  register_sub_command(user, User)

  def run
    puts help
  end
end

Projectdbctl.run()
