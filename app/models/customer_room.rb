# frozen_string_literal: true

class CustomerRoom < ApplicationRecord
  belongs_to :customer
  belongs_to :room
  validates :customer_id, presence: true
  validates :room_id, presence: true
  has_many :chats, through: :room

  # チャット相手とのルーム検索
  def self.find_customer_rooms(current_customer, other_customer)
    rooms_ids = current_customer.customer_rooms.pluck(:room_id)
    CustomerRoom.find_by(customer_id: other_customer.id, room_id: rooms_ids)
  end

  # 個別のルームに未読の通知があるか確認（チャット）

  def message_checked
    chats.where(customer_id: customer_id, checked: false).any?
  end
end
