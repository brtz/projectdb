class Environment < ApplicationRecord
  validates :name, uniqueness: true
  
  encrypts :name, deterministic: true, downcase: true
  
  belongs_to :project
end
