class Project < ApplicationRecord
    validates :name, uniqueness: true
    validates :shorthandle, uniqueness: true

    encrypts :name, deterministic: true, downcase: true
    encrypts :shorthandle, deterministic: true, downcase: true
    encrypts :description

    has_many :environments, dependent: :destroy
    belongs_to :user
end
