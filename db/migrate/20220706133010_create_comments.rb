# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :customer_id
      t.text :comment_content

      t.timestamps
    end
  end
end
