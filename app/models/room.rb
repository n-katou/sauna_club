class Room < ApplicationRecord
has_many :chats, dependent: :destroy
has_many :customer_rooms, dependent: :destroy
has_many :customers,  through: :customer_rooms
end
