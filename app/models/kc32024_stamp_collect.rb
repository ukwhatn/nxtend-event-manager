class Kc32024StampCollect < ApplicationRecord
  belongs_to :user
  belongs_to :kc32024_stamp
  validates :user_id, presence: true
  validates :kc32024_stamp_id, presence: true
  validates_uniqueness_of :user_id, scope: :kc32024_stamp_id
end
