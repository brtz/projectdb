class ApiUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList

  self.skip_session_storage = [:http_auth]

  def jwt_payload
    {
      'email' => email
    }
  end
end
