class UserSeen < ApplicationRecord
  belongs_to :message
  has_many :users
end
