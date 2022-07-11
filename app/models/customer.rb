class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts #アカウントが消えても投稿を残したい場合はどうしたら良いのか
  has_many :favorites,dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :comments,dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end



  # ユーザーをフォローする
  def follow(other_customer)
    following << other_customer
  end

  # ユーザーをフォロー解除する
  def unfollow(other_customer)
    active_relationships.find_by(followed_id: other_customer.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_customer)
    following.include?(other_customer)
  end

end
