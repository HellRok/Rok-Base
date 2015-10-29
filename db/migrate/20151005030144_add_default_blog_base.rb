class AddDefaultBlogBase < ActiveRecord::Migration
  def change
    change_column :rok_base_sites, :blog_base, :string, default: 'blog'
  end
end
