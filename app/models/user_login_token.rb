class UserLoginToken < ApplicationRecord
  validates :discord_id, presence: true
  validates :token, presence: true, uniqueness: true
  validates :expires_at, presence: true
  validates :is_used, inclusion: { in: [true, false] }
end
