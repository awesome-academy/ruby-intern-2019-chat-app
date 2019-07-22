class UserRoom < ApplicationRecord
  has_many :users
  belongs_to :room
end
