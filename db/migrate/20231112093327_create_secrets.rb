# frozen_string_literal: true

class CreateSecrets < ActiveRecord::Migration[7.1]
  enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")
  def change
    create_table :secrets, id: :uuid do |t|
      t.string :name, null: false
      t.text :content, null: false

      # do not use t.belongs_to here, does not work
      t.references :environment, type: :uuid

      t.timestamps
    end
  end
end
