class Review < ApplicationRecord

  belongs_to :user
  belongs_to :novel



  validates :comment, uniqueness: true ,length: {minimum: 2}

end
