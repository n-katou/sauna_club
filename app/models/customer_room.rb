class CustomerRoom < ApplicationRecord
  belongs_to :customer
  belongs_to :room
  validates :customer_id, presence: true
  validates :room_id, presence: true
  has_many :chats, through: :room
end
