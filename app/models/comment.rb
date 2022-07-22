class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :customer

  validates :comment_content, presence: true
end
