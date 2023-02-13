class Novel < ApplicationRecord

  belongs_to :user
  has_many :reviews, dependent: :destroy

  #ノベルとジャンルの中間テーブル
  has_many :tags, dependent: :destroy

  #ジャンル(タグ)の中間テーブルを介した関連付け
  has_many :genres, through: :tags, dependent: :destroy
  accepts_nested_attributes_for :tags

  has_many :bookmarks, dependent: :destroy


  validates :title, {
    presence: true,
    length: {in: 2..50}
  }

  validates :body, {
    presence: true,
    length: {in: 10..6000}
  }

  validates :foreword, length: {maximum:300}

  validates :afterword, length: {maximum:300}

  validates :logline, {
    presence: true,
    length: {in: 10..100}
  }



  #ユーザーIDが存在？するかどうかを調べる。存在していれば、trueを返す
 def bookmarked_by?(user)
    # favorites.exists?(user_id: user.id)
    bookmarks.where(user_id: user).exists?
 end

#非公開(下書き保存)にするか、公開(投稿)するか
   enum novel_status: {novel_public: 0, novel_private: 1}



# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @novel = Novel.where("title LIKE?","#{word}")
    elsif search == "partial_match"
      @novel = Novel.where("title LIKE?","%#{word}%")
    else
      @novel = Novel.all
    end
  end




end
