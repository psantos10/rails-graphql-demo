class User < ApplicationRecord
  has_secure_password

  has_many :links
  has_many :votes

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
