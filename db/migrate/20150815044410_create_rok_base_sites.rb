class CreateRokBaseSites < ActiveRecord::Migration
  def change
    create_table :rok_base_sites do |t|
      t.string :name
      t.string :host
      t.text :scss
      t.text :javascript
      t.text :compiled_css

      t.timestamps null: false
    end

    add_index :rok_base_sites, :host, unique: true
  end
end
