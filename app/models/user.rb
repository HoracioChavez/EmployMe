class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  before_create :create_remember_token

  has_secure_password
  has_many :orders

  # has_attached_file :pdf
  # validates_attachment_content_type :pdf, :content_type => ["application/pdf"]

  validates :password,              presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  validates :first_name,            presence: true, length: { maximum: 30 }
  validates :last_name,             presence: true, length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_many :listings, foreign_key: :creator_id

  def self.default_status
    self.status ||= "default"
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
