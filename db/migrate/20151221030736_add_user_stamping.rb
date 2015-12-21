class AddUserStamping < ActiveRecord::Migration
  def change
    add_column :rok_base_sites, :creator_id, :integer
    add_column :rok_base_sites, :updater_id, :integer
    add_column :rok_base_uploads, :creator_id, :integer
    add_column :rok_base_uploads, :updater_id, :integer
  end
end
