require "dexter"

module Common
  def self.log(severity, message, exception = nil)
    backend = Log::IOBackend.new
    backend.formatter = Dexter::JSONLogFormatter.proc
    Log.dexter.configure(:info, backend)
        
    case severity
    when "info"
      Log.dexter.info { { message: message } }
    when "error"
      Log.dexter.error(exception: exception) { { message: message } }
    else
      Log.dexter.warn { { message: message } }
    end
  end
end