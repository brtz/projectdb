# frozen_string_literal: true

class Project < ApplicationRecord
  attribute :start_datetime, :datetime
  attribute :end_datetime, :datetime

  validates :name, uniqueness: true
  validates :shorthandle, uniqueness: true
  validates :custom_id, uniqueness: true

  encrypts :name, deterministic: true, downcase: true
  encrypts :shorthandle, deterministic: true, downcase: true
  encrypts :description
  encrypts :custom_id, deterministic: true, downcase: true

  has_many :environments, dependent: :destroy
  has_many :children, class_name: "Project", foreign_key: "parent_id"

  belongs_to :parent, class_name: "Project", optional: true
  belongs_to :user
end
