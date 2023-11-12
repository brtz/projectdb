class Environment < ApplicationRecord
  validates :name, uniqueness: true
  validates :shorthandle, uniqueness: true
  
  encrypts :name, deterministic: true, downcase: true
  encrypts :shorthandle, deterministic: true, downcase: true
  
  belongs_to :project
end
