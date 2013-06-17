class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :comic_id 
      t.integer :page_number 

      t.string :image_url 
      
      t.timestamps
    end
  end
end
