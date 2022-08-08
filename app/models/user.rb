class User < ActiveRecord::Base
  has_secure_password validations: true

  validates :name, presence: true, uniqueness: true
end
