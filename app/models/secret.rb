class Secret < ApplicationRecord
    encrypts :name
    encrypts :content
    
    belongs_to :environment
end
