# frozen_string_literal: true

class CreateCustomerRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_rooms do |t|
      t.references :customer, foreign_key: true, null: false
      t.references :room, foreign_key: true, null: false

      t.timestamps
    end
    add_index :customer_rooms, [:customer_id, :room_id], unique: true
  end
end
