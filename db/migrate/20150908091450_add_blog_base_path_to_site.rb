class AddBlogBasePathToSite < ActiveRecord::Migration
  def change
    add_column :rok_base_sites, :blog_base, :string
  end
end
