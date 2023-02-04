class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  #退会したら、そのアカウントではログインできなくなる。
  def active_for_authentication?
    super && (is_deleted == false)
  end

end
