class User < ApplicationRecord
  validates :discord_id, presence: true, uniqueness: true

  validates :last_name, presence: true, length: { minimum: 1, maximum: 25 }
  validates :first_name, presence: true, length: { minimum: 1, maximum: 25 }
  validates :last_name_kana, presence: true, length: { minimum: 1, maximum: 25 }
  validates :first_name_kana, presence: true, length: { minimum: 1, maximum: 25 }

  validates :email, presence: true, length: { minimum: 1, maximum: 255 }, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :school_name, length: { maximum: 255 }
  validates :graduation_year, numericality: { only_integer: true, greater_than_or_equal_to: 2020, less_than_or_equal_to: 2030 }, allow_nil: true
  validates :circle_name, length: { maximum: 255 }

  has_many :user_event_attendances, dependent: :destroy
  has_many :events, through: :user_event_attendances

  has_many :user_program_attendances, dependent: :destroy
  has_many :event_programs, through: :user_program_attendances

  def self.find_by_discord_id(discord_id)
    User.find_by(discord_id: discord_id)
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  def full_name_kana
    "#{last_name_kana} #{first_name_kana}"
  end

  def self.get_user_from_session(session)
    if session[:user_id].present?
      User.find_by(id: session[:user_id])
    else
      nil
    end
  end

end
