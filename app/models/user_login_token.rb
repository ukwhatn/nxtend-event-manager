class UserLoginToken < ApplicationRecord
  validates :discord_id, presence: true
  validates :token, presence: true, uniqueness: true
  validates :expires_at, presence: true
  validates :is_used, inclusion: { in: [true, false] }

  def self.find_by_token(token)
    UserLoginToken.find_by(token: token)
  end

  def find_user
    User.find_by(discord_id: discord_id)
  end

  def is_expired
    expires_at < Time.now
  end

  def create(discord_id)
    token = SecureRandom.hex(32)
    expires_at = Time.now + 1.hour
    UserLoginToken.create(
      discord_id: discord_id,
      token: token,
      expires_at: expires_at
    )
  end

  def mark_used
    update(is_used: true)
  end
end
