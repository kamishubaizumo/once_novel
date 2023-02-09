class Review < ApplicationRecord

  belongs_to :user
  belongs_to :novel
  
    validates :star_rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1,
  }, presence: true
  
  validates :comment, 

end
