class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :body
      t.attachment :image

      t.timestamps null: false
    end
  end
end
