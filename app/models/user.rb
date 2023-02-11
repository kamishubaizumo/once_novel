class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :novels, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  validates :name, length: {in: 2..10}
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
    super && (is_deleted == "有効")
  end
  # == false　が原因でログインを弾かれた。"有効"にして解消。


  enum is_deleted: {退会済み: true, 有効: false}


end
