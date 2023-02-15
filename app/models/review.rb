class Review < ApplicationRecord

  belongs_to :user
  belongs_to :novel



  validates :comment, length: {minimum: 2}

end
