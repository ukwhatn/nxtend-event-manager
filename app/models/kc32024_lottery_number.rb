class Kc32024LotteryNumber < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :number, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than: 0, less_than: 201 }

  def self.create_lottery_number
    # 1-200の数字を重複を許さずに１つ作成
    number = nil
    loop do
      number = rand(1..200)
      break unless Kc32024LotteryNumber.exists?(number: number)
    end
    number
  end
end
