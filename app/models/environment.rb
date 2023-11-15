# frozen_string_literal: true

class Environment < ApplicationRecord
  validates :name, uniqueness: true
  validates :shorthandle, uniqueness: true

  encrypts :name, deterministic: true, downcase: true
  encrypts :shorthandle, deterministic: true, downcase: true
  encrypts :description

  has_many :secrets, dependent: :destroy
  belongs_to :project
end
