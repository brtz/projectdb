require "./common"
require "halite"

module ModResource
  def self.list(resource, api_url)
    begin
      jwt = load_jwt()
      url = "#{api_url}/#{resource}"

      res = Halite.get(url, headers: {
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{jwt}"
      })

      if res.status_code == 200
        puts res.body
      else
        raise "Could not list resource #{resource} from #{url} (#{res.status_code})"
      end

    rescue ex
      Common.log("error", ex.message, ex)
      exit(1)
    end
  end

  private def self.load_jwt() : String
    begin
      jwt = File.read("/tmp/.projectdbctl-jwt")
      return jwt
    rescue ex
      Common.log("error", ex.message, ex)
      exit(1)
    end
  end
end
