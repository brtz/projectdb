# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate_api_user!, if: -> { request.format.json? }
  before_action :authenticate_user!, if: -> { request.format.html? }
  before_action :define_role

  def index
  end

  private
    def define_role
      if !current_api_user.nil?
        @current_role = "admin"
      else
        if current_user.nil?
          @current_role = nil
        else
          case current_user.current_role
          when "admin"
            @current_role = "admin"
          else
            @current_role = "user"
          end
        end
      end
    end
end
