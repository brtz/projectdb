# frozen_string_literal: true

class Secret < ApplicationRecord
  encrypts :name
  encrypts :content

  belongs_to :environment
end
