# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :customer_rooms, dependent: :destroy
  has_many :customers,  through: :customer_rooms

  # チャット通知を既読にするためのメゾット
  def check_chats_notification(current_customer)
    unchecked_chats = chats.includes(:customer).where(checked: false).where.not(customer_id: current_customer.id)
    unchecked_chats&.each { |unchecked_chat| unchecked_chat.update(checked: true) }
  end
end
