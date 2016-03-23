class AddThumbToProducts < ActiveRecord::Migration
  def change
    add_column :products, :thumb, :text
  end
end
