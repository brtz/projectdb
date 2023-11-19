# frozen_string_literal: true

class Secret < ApplicationRecord
  validates :name, uniqueness: true

  encrypts :name, deterministic: true, downcase: true
  encrypts :content

  belongs_to :environment
end
