class UserSong < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  has_many :user_scores

  # ransack 4系では検索対象の属性・関連を明示的に許可する必要がある
  def self.ransackable_attributes(auth_object = nil)
    %w[is_favorite]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[song user_scores]
  end
end