class Bookmark < ApplicationRecord

  belongs_to :user
  has_many :novels, dependent: :destroy

#重複登録防止
validates :user_id, uniqueness: { scope: :novel_id }

end
