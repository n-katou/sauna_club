class Post < ApplicationRecord
  belongs_to :customer
  has_many :comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :taggings,dependent: :destroy
  
  has_one_attached :post_image
end
