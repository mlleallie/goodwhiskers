class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.text :mfg
      t.text :description
      t.text :url
      t.text :image
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
