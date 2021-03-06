class User < ApplicationRecord
  include SecureRandom
  after_initialize :assign_api_key, :downcase_email
  has_many :user_searches
  has_many :searches, through: :user_searches
  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, confirmation: { case_sensitive: true }

  def assign_api_key
    self.api_key = SecureRandom.base64.tr('+/=', 'Qrt')
  end

  def downcase_email
    if self.email
      self.email = self.email.downcase
    end
  end
end
