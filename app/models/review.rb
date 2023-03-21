class Review < ApplicationRecord

  belongs_to :user
  belongs_to :novel



  validates :comment,presence: true, length: {minimum: 2}

end
