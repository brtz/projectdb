class Project < ApplicationRecord
    encrypts :name
    encrypts :shorthandle
    encrypts :description
    encrypts :contact_person

    validates :name, uniqueness: true
    validates :shorthandle, uniqueness: true
end
