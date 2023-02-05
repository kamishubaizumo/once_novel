class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :novels, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy






  #退会したら、そのアカウントではログインできなくなる。
  def active_for_authentication?
    super && (is_deleted == "有効")
  end
  # == false　が原因でログインを弾かれた。"有効"にして解消。


  enum is_deleted: {退会済み: true, 有効: false}


end
