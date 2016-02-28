class CreateSearchEngineOptimizations < ActiveRecord::Migration
  def change
    create_table :search_engine_optimizations do |t|
      t.string :name
      t.string :content

      t.timestamps null: false
    end
  end
end
