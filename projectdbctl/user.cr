require "./common"
require "halite"

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
          "Content-Type" => "application/json"
        }
      )

      if (res.status_code == 200)
        jwt = res.headers["Authorization"].sub("Bearer ", "")
      else
        raise "Auth failed"
      end

      File.write("/tmp/.projectdbctl-jwt", jwt)
      Common.log("info", "Successfully authed")
    rescue ex
      Common.log("error", ex.message, ex)
      exit(1)
    end
  end
end
