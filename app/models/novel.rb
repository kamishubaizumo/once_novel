class Novel < ApplicationRecord

  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :genres, dependent: :destroy
  has_many :bookmark, dependent: :destroy


  # validates :title, {
  #   presence: true,
  #   length: {in: 2..50}
  # }

  # validates :body, {
  #   presence: true,
  #   length: {in: 10..6000}
  # }

  # validates :foreword, {maximum:300}

  # validates :afterword, {maximum:300}

  # validates :logline, {
  #   presence: true,
  #   length: {in: 10..100}
  # }


#非公開(下書き保存)にするか、公開(投稿)するか
   enum novel_status: {公開: 0, 非公開: 1, 下書き保存: 2}


end
