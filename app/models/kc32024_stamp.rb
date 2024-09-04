class Kc32024Stamp < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :collection_token, presence: true
  has_many :kc32024_stamp_collects
  has_many :users, through: :kc32024_stamp_collects
end
