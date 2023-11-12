class Environment < ApplicationRecord
  validates :name, uniqueness: true
  validates :shorthandle, uniqueness: true
  
  encrypts :name, deterministic: true, downcase: true
  encrypts :shorthandle, deterministic: true, downcase: true
  
  has_many :secrets, dependent: :destroy
  belongs_to :project
end
