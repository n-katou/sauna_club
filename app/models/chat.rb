# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :customer
  belongs_to :room
  validates :customer_id, presence: true
  validates :room_id, presence: true
  validates :message, presence: true
end
