# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :customer, foreign_key: true, null: false
      t.references :room, foreign_key: true, null: false
      t.string :message, null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
