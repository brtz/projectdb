class Project < ApplicationRecord
    validates :name, uniqueness: true
    validates :shorthandle, uniqueness: true
    validates :custom_id, uniqueness: true

    encrypts :name, deterministic: true, downcase: true
    encrypts :shorthandle, deterministic: true, downcase: true
    encrypts :description
    encrypts :custom_id, deterministic: true, downcase: true

    has_many :environments, dependent: :destroy
    belongs_to :user
end
