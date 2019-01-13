class User < ApplicationRecord
  has_many :questions
  has_many :responses
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end
