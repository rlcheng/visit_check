class User < ActiveRecord::Base
  has_secure_password
  validates_uniqueness_of :email
  validates :password, length: { minimum: 8 }, allow_nil: true
  has_many :visits
end
