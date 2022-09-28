class User < ActiveRecord::Base
  has_many :user_songs
  has_many :songs, through: :user_songs
  has_secure_password validations: true
  before_save { name.downcase! }

  validates :name, presence: true, uniqueness: true
end
