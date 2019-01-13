class Response < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :body, presence: true
  validates :body, length: { minimum: 50 }
  validates :user_id, presence: true
  validates :question_id, presence: true
end
