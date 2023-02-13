class Review < ApplicationRecord

  belongs_to :user
  belongs_to :novel

    # validates :star_rate, numericality: {
    #   # 最大5
    # less_than_or_equal_to: 5,
    # # 最小1
    # greater_than_or_equal_to: 1,
    # }

  validates :comment, length: {minimum: 2}

end
