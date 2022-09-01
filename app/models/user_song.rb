class UserSong < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  has_many :user_scores
end