# frozen_string_literal: true

class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :post_id

      t.timestamps
    end
  end
end
