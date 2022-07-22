class Tag < ApplicationRecord
  has_many :taggings
  validates :tag_name, presence: true
end
