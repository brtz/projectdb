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

    class Spec < Admiral::Command
      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          ModResource.spec("projects", api_url)
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    class Add < Admiral::Command
      define_flag file : String, description: "path to resource file.", short: f, long: file, required: true

      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          ModResource.create("projects", api_url, flags.file)
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    class Delete < Admiral::Command
      define_flag id : String, description: "resource's id to be deleted.", short: i, long: id, required: true
      define_flag confirm : String, description: "need to be set to true to delete resources.", long: confirm, required: true

      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          if (flags.confirm == "true")
            ModResource.delete("projects", api_url, flags.id)
          end
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    register_sub_command(list, List)
    register_sub_command(spec, Spec)
    register_sub_command(add, Add)
    register_sub_command(delete, Delete)

    def run
      puts help
    end
  end

  class Environment < Admiral::Command
    define_help description: "Environment related commands"

    class List < Admiral::Command
      define_flag filters : Array(String), description: "Filters. Can be specified multiple times. Combined by &. e.g. name:*foo*", short: f, long: filter

      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          ModResource.list("environments", api_url, flags.filters)
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    class Spec < Admiral::Command
      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          ModResource.spec("environments", api_url)
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    class Add < Admiral::Command
      define_flag file : String, description: "path to resource file.", short: f, long: file, required: true

      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          ModResource.create("environments", api_url, flags.file)
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    class Delete < Admiral::Command
      define_flag id : String, description: "resource's id to be deleted.", short: i, long: id, required: true
      define_flag confirm : String, description: "need to be set to true to delete resources.", long: confirm, required: true

      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          if (flags.confirm == "true")
            ModResource.delete("environments", api_url, flags.id)
          end
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    register_sub_command(list, List)
    register_sub_command(spec, Spec)
    register_sub_command(add, Add)
    register_sub_command(delete, Delete)

    def run
      puts help
    end
  end

  class Secret < Admiral::Command
    define_help description: "Secret related commands"

    class List < Admiral::Command
      define_flag filters : Array(String), description: "Filters. Can be specified multiple times. Combined by &. e.g. name:*foo*", short: f, long: filter

      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          ModResource.list("secrets", api_url, flags.filters)
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    class Spec < Admiral::Command
      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          ModResource.spec("secrets", api_url)
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    class Add < Admiral::Command
      define_flag file : String, description: "path to resource file.", short: f, long: file, required: true

      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          ModResource.create("secrets", api_url, flags.file)
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    class Delete < Admiral::Command
      define_flag id : String, description: "resource's id to be deleted.", short: i, long: id, required: true
      define_flag confirm : String, description: "need to be set to true to delete resources.", long: confirm, required: true

      def run
        begin
          api_url = ENV["PROJECTDBCTL_API_URL"]
          if (flags.confirm == "true")
            ModResource.delete("secrets", api_url, flags.id)
          end
        rescue ex
          puts ex.message
          exit(1)
        end
      end
    end

    register_sub_command(list, List)
    register_sub_command(spec, Spec)
    register_sub_command(add, Add)
    register_sub_command(delete, Delete)

    def run
      puts help
    end
  end

  register_sub_command(user, User)
  register_sub_command(project, Project)
  register_sub_command(environment, Environment)
  register_sub_command(secret, Secret)

  def run
    puts help
  end
end

Projectdbctl.run()
