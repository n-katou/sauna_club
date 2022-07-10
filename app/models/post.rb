class Post < ApplicationRecord
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings #上にスルーするtaggingsが来ないとエラーになる。

  # post = Post.new
  # post.tags　#これで紐づいたタグを簡単に持ってこれる。

  # tags = post.taggings.map {|tagging| tagging.tags }.flatten #throughを使わない場合はこうやってビューに記述しないといけない。

  has_one_attached :post_image

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id) #これの意味もいまいちわからない
  end

end
