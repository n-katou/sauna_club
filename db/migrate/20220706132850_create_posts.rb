class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id
      t.integer :tag_id
      t.string :title
      t.text :post_content
      t.timestamps
    end
  end
end
