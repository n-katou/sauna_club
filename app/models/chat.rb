class Chat < ApplicationRecord
  belongs_to :customer
  belongs_to :room
  validates :customerr_id, presence: true
  validates :room_id, presence: true
  validates :message, presence: true
end
