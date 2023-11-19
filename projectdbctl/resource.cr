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
          puts elements.to_json
        end
      else
        raise "Could not list resource #{resource} from #{url} (#{res.status_code})"
      end

    rescue ex
      Common.log("error", ex.message, ex)
      exit(1)
    end
  end

  def self.spec(resource, api_url)
    begin
      jwt = load_jwt()
      url = "#{api_url}/#{resource}/spec"

      res = Halite.get(url, headers: {
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{jwt}"
      })

      if res.status_code == 200
        spec = JSON.parse(res.body)
        spec.as_h.delete("id")
        spec.as_h.delete("created_at")
        spec.as_h.delete("updated_at")

        File.write("/tmp/projectdbctl-spec-#{resource}", spec.to_pretty_json)
        puts "Wrote spec for #{resource} to: /tmp/projectdbctl-spec-#{resource}"
      else
        raise "Could not spec resource #{resource} from #{url} (#{res.status_code})"
      end

    rescue ex
      Common.log("error", ex.message, ex)
      exit(1)
    end
  end

  def self.create(resource, api_url, file)
    begin
      jwt = load_jwt()
      url = "#{api_url}/#{resource}"

      # parse needed, so we format it right removing newlines etc.
      content = JSON.parse(File.read(file)).to_json

      res = Halite.post(url, headers: {
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{jwt}"
      }, raw: %Q{{"#{resource.chomp("s")}": #{content}}})

      if res.status_code == 200
        puts res.body
      else
        raise "Could not create resource #{resource} at #{url} (#{res.status_code})"
      end

    rescue ex
      Common.log("error", ex.message, ex)
      exit(1)
    end
  end

  def self.update(resource, api_url, file, id)
    begin
      jwt = load_jwt()
      url = "#{api_url}/#{resource}/#{id}"

      # parse needed, so we format it right removing newlines etc.
      content = JSON.parse(File.read(file)).to_json

      res = Halite.put(url, headers: {
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{jwt}"
      }, raw: %Q{{"#{resource.chomp("s")}": #{content}}})

      if res.status_code == 200
        puts res.body
      else
        raise "Could not update resource #{resource} at #{url} (#{res.status_code})"
      end

    rescue ex
      Common.log("error", ex.message, ex)
      exit(1)
    end
  end

  def self.delete(resource, api_url, id)
    begin
      jwt = load_jwt()
      url = "#{api_url}/#{resource}/#{id}"

      res = Halite.delete(url, headers: {
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{jwt}"
      })

      if res.status_code < 303
        Common.log("info", "Successfully deleted resource #{resource} with id #{id}")
      else
        raise "Could not delete resource #{resource} from #{url} (#{res.status_code})"
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
