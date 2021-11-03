class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # , authentication_keys: [:username]

  validates :email, presence: true
  validates :username, presence: true
  validates :gender, presence: true

  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy

  has_many :followers, foreign_key: 'follower_id', class_name: 'Relationship'
  has_many :followed, foreign_key: 'followed_id', class_name: 'Relationship'

  def have_relation?(followed_id, current_user_id)
    Relationship.where(
      follower: current_user_id,
      followed: followed_id).blank?
  end

end
