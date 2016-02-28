class FixNaviagition < ActiveRecord::Migration
  def change
    create_table :navigation_nodes do |t|
      t.string :title
      t.string :slug
      t.string :position
      t.string :ancestry
      t.timestamps
    end
    add_index :navigation_nodes, :ancestry
    rename_table :navigation_nodes, :piggybak_taxonomy_navigation_nodes
    rename_table :sellable_taxonomies, :piggybak_taxonomy_sellable_taxonomies
  end
end
