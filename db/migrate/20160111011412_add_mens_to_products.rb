class AddMensToProducts < ActiveRecord::Migration
  def change
    add_column :products, :mens, :booleans
  end
end
