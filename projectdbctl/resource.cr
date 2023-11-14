require "./common"
require "halite"

module ModResource
  def self.list(resource, api_url, filters)
    begin
      jwt = load_jwt()
      url = "#{api_url}/#{resource}"

      res = Halite.get(url, headers: {
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{jwt}"
      })

      if res.status_code == 200
        if filters.empty?
          puts res.body
        else
          elements = JSON.parse(res.body)
          elements = self.filter_elements(elements, filters)
          puts elements.to_pretty_json
        end
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

  private def self.filter_elements(elements, filters)
    filters.each do |filter|
      field = filter.split(seperator = ':', limit = 2)[0]
      value = filter.split(seperator = ':', limit = 2)[1]

      elements.as_a.each do |element|
        if !File.match?(value, element[field].to_s)
          elements.as_a.delete(element)
          self.filter_elements(elements, filters)
          break
        end
      end
    end

    return elements
  end
end
