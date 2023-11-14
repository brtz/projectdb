class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :lockable,
         :rememberable,
         :trackable,
         :validatable

  encrypts :first_name
  encrypts :last_name

  has_many :projects
end
