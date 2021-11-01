class Relationship < ApplicationRecord
  
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def exist?(followed_id, current_user_id)
    Relationship.where(
      follower: current_user_id,
      followed: followed_id).blank?
  end

end
