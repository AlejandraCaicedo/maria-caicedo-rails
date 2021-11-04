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

  has_many :following, foreign_key: 'follower_id', class_name: 'Relationship'
  has_many :followers, foreign_key: 'followed_id', class_name: 'Relationship'

end
