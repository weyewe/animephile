class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title 
      t.string :url 
      
      t.integer :total_page 
      t.timestamps
    end
  end
end
