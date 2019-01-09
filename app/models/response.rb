class Response < ApplicationRecord
  validates :body, presence: true
  validates :body, length: { minimum: 50 }
  validates :user_id, presence: true
end
