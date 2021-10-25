class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  validates :name, presence: true
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
end
