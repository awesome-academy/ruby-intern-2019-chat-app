class UserRoom < ActiveRecord
  has_many :users
  belongs_to :room
end
