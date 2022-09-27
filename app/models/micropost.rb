class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites, dependent: :destroy
  has_many :user_list, through: :favorites, source: :user
  
  def counts_favorites_user_list
    self.user_list.count
  end
end
