class AddNameToUploads < ActiveRecord::Migration
  def change
    add_column :rok_base_uploads, :name, :string
  end
end
