class CreateProjects < ActiveRecord::Migration[7.1]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name,              null: false, default: ""
      t.string :shorthandle, null: false, default: ""
      t.text :description, null: false, default: ""
      t.string :contact_person, null: false, default: ""
      t.uuid :parent_id, null: true

      t.timestamps
    end
  end
end
