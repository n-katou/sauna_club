class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #アカウントが消えても投稿を残したい場合はdependet: :destroyを記述しない
  has_many :posts

  has_many :favorites,dependent: :destroy

  #フォローした、されたの関係
  has_many :relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  #一覧画面で使用
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :comments,dependent: :destroy

  #チャット機能
  has_many :customer_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

  has_one_attached :profile_image

  validates :account_name, presence: true

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end



  # ユーザーをフォローする
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end

  # ユーザーをフォロー解除する
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(customer)
    followings.include?(customer)
  end

  #ゲストログイン sessions_controllerで使用
  def self.guest
    find_or_create_by!(email: 'aaa@aaa.com') do |customer|
      customer.password = SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'0'..'9'].sample(1).join
      customer.password_confirmation = customer.password
      customer.account_name = 'ゲスト'
    end
  end

  #ゲストログインの閲覧のみのメソッド　application_controllerで
  def guest?
    email == 'aaa@aaa.com'
  end
  
  #未読の通知が存在するか確認(チャット)
  def unchecked_chats?
    my_rooms_ids = CustomerRoom.select(:room_id).where(customer_id: id)
    other_customer_ids = CustomerRoom.select(:customer_id).where(room_id: my_rooms_ids).where.not(customer_id: id)
    Chat.where(customer_id: other_customer_ids, room_id: my_rooms_ids).where.not(checked: true).any?
  end

end
