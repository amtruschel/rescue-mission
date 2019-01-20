class User < ApplicationRecord
  has_many :questions
  has_many :responses
  validates :email, presence: true

  def self.find_or_create_from_auth_hash(auth)
    where(provider: auth.provider, email: auth.info.email).first_or_initialize.tap do |user|
      user.uid = auth.uid
      user.email = auth.info.email
      user.provider = auth.provider
      user.avatar_url = auth.info.image
      user.username = auth.info.name
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end
end
