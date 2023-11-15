# frozen_string_literal: true

class CreateEnvironments < ActiveRecord::Migration[7.1]
  enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")
  def change
    create_table :environments, id: :uuid do |t|
      t.string :name, null: false, default: ""
      t.text :description, null: false, default: ""
      t.string :shorthandle, null: false, default: ""

      # do not use t.belongs_to here, does not work
      t.references :project, type: :uuid

      t.timestamps
    end
  end
end
