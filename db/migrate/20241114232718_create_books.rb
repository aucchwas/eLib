class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.decimal :price
      t.string :publisher

      t.timestamps
    end
  end
end
