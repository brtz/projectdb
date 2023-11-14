require "dexter"
require "halite"

backend = Log::IOBackend.new
backend.formatter = Dexter::JSONLogFormatter.proc
Log.dexter.configure(:info, backend)

module ModUser
  def self.auth(api_url, api_username, api_password)
    begin
      res = Halite.post(api_url + "/users/sign_in",
        json: { "user" => {
          "email" => api_username,
          "password" => api_password
        }},
        headers: {
          "Accept" => "application/json",
          "content-type" => "application/json"
        }
      )

      if (res.status_code == 200)
        jwt = res.headers["Authorization"].sub("Bearer ", "")
      else
        raise "Auth failed"
      end

      File.write("/tmp/.projectdbctl-jwt", jwt)
      Log.info { "Successfully authed" }

    rescue ex
      Log.error { ex.message }
      exit(1)
    end
  end
end
