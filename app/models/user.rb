class User < ActiveRecord::Base
  has_many :favorites
  has_secure_password
  validates :username, uniqueness: true
end
