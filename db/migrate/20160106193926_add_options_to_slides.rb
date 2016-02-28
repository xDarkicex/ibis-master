class AddOptionsToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :header, :string
    add_column :slides, :sub_header, :string
    add_column :slides, :button_name, :string
    add_column :slides, :url, :string
  end
end
