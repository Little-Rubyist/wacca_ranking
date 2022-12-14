class User < ActiveRecord::Base
  has_many :user_songs
  has_many :songs, through: :user_songs
  has_secure_password validations: true
  before_save { name.downcase! }

  VALID_NAME_REGEX = /\A[0-9a-zA-Z-_]*\z/
  validates :name, presence: true, uniqueness: true, format: { with: VALID_NAME_REGEX }
end
