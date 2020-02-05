class Follow < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :follow_user_id, presence: true
  validates :active, presence: true
  validate :follow_already_exist?



  def follow_already_exist?
    if Follow.where(["user_id = ? and follow_user_id = ? and active = ?", self.user_id, self.follow_user_id, true]).count == 0
      return false
    else
      return true
    end
  end

end
