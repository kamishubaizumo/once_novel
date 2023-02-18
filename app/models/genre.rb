class Genre < ApplicationRecord

  #novelとgenreの中間テーブル
  has_many :tags, dependent: :destroy


  #genreテーブルから中間テーブルtagを介して、novelテーブルへの関連付け
  has_many :novels, through: :tags, dependent: :destroy


  validates :genre, presence: true, uniqueness: true,length: {in: 1..20}

end
