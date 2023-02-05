class Novel < ApplicationRecord

  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :genres, dependent: :destroy
  has_many :bookmark, dependent: :destroy


  validates :title, {
    presence: true,
    length: {in: 2..20}
  }

  validates :body, {
    presence: true,
    length: {in: 10..6000}
  }

  validates :foreword, {maximum:300}

  validates :afterword, {maximum:300}

  validates :logline, {
    presence: true,
    length: {in: 10..100}
  }


  enum novel_status: {draft: false, published: true}


end
