class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.belongs_to :user
      t.belongs_to :company

      t.timestamps
    end
    Product.create_translation_table! title: :string
  end
end
