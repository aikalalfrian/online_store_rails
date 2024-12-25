class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, limit: 255
      t.integer :stock_quantity
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
