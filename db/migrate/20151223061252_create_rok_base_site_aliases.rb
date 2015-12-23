class CreateRokBaseSiteAliases < ActiveRecord::Migration
  def up
    create_table :rok_base_site_aliases do |t|
      t.integer :site_id, null: false
      t.string :host, null: false
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps null: false
    end

    execute(<<-SQL)
      INSERT INTO rok_base_site_aliases (site_id, host, created_at, updated_at)
        SELECT id, host, now(), now() FROM rok_base_sites;
    SQL

    remove_column :rok_base_sites, :host
    add_index :rok_base_site_aliases, :site_id
  end

  def down
    add_column :rok_base_sites, :host, :string
    drop_table :rok_base_site_aliases
  end
end
