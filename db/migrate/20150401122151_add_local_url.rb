class AddLocalUrl < ActiveRecord::Migration
  def up
  	add_column :pages, :local_url, :string
  end

  def down
  end
end
