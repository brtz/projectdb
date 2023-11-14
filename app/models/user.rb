class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList,
         :lockable,
         :rememberable,
         :trackable,
         :validatable

  encrypts :first_name
  encrypts :last_name

  has_many :projects

  def jwt_payload
    {
      'email' => email,
      'first_name' => first_name,
      'last_name' => last_name
    }
  end
end
