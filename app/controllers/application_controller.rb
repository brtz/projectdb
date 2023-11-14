class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate_api_user!, if: -> { request.format.json? }
  before_action :authenticate_user!, if: -> { request.format.html? }

  def index
  end

end
