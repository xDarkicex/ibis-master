class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :asset
      t.timestamps null: false
    end
  end
end
