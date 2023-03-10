class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #ユーザーが管理者側のページに遷移しないようにするには？？
  #applicationコントローラに、adminのページにユーザーがいけないようにする記述をかいてある。

  has_many :novels, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :name, length: {in: 2..20}
  validates :infomation, length: { maximum: 100}



# フォローをした、されたの関係
has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

# 一覧画面で使う
has_many :followings, through: :relationships, source: :followed
has_many :followers, through: :reverse_of_relationships, source: :follower


# フォローした時
def follow(user_id)
  relationships.create(followed_id: user_id)
end
# フォローを外した時
def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
end
# フォローしているか？
def following?(user)
  followings.include?(user)
end




  #退会したら、そのアカウントではログインできなくなる。
  def active_for_authentication?
    super && !is_deleted
  end
  # == false　が原因でログインを弾かれた。"有効"にして解消。


#退会したユーザーを検索結果に表示させないようにするには？？


# 検索方法分岐
  def self.looks(search, word)

    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end


  #ゲストログイン機能 routes.rbにルーティング設定 session_controller.rbに記述
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end




end
