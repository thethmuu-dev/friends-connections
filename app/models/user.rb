class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
    has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :active_relationships, source: :follower
end
