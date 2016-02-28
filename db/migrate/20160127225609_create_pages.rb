class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.timestamps null: false
    end
    add_column :pages, :title, :string
    add_column :pages, :header, :string
    add_column :pages, :content, :string
  end
end
