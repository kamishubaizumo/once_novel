class Bookmark < ApplicationRecord

  belongs_to :user
  belongs_to :novel

#重複登録防止
validates :user_id, uniqueness: { scope: :novel_id }

end
