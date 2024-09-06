class UserLoginToken < ApplicationRecord
  validates :discord_id, presence: true
  validates :token, presence: true, uniqueness: true
  validates :expired_at, presence: true
  validates :is_used, inclusion: { in: [true, false] }

  def self.find_by_token(token)
    UserLoginToken.find_by(token: token)
  end

  def find_user
    User.find_by(discord_id: discord_id)
  end

  def is_expired
    expired_at < Time.now
  end

  def self.create_with_token(discord_id)
    # discord_idが同一で未使用・有効期限内のトークンがあればそれを返す
    token_data = UserLoginToken.find_by(discord_id: discord_id)
    return token_data if token_data.present? && !token_data.is_expired

    # discord_idが同一で未使用・有効期限内のトークンがなければ新規作成
    token = SecureRandom.hex(32)
    expired_at = Time.now + 1.hour
    puts "discord_id: #{discord_id}"
    UserLoginToken.create!(
      discord_id: discord_id,
      token: token,
      expired_at: expired_at
    )
  end

  def mark_used
    update(is_used: true)
  end
end
