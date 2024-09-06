class Kc32024Stamp < ApplicationRecord
  validates :name, presence: true
  validates :collection_token, presence: true
  validates :is_required, inclusion: { in: [true, false] }

  has_many :kc32024_stamp_collects, dependent: :destroy
  has_many :users, through: :kc32024_stamp_collects
end
