class CreateRokBaseUploads < ActiveRecord::Migration
  def change
    create_table :rok_base_uploads do |t|
      t.integer :site_id
      t.string :file

      t.timestamps null: false
    end

    add_index :rok_base_uploads, :site_id
  end
end
