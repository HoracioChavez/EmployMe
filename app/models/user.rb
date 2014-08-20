class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  
  has_secure_password
  
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  
  validates :first_name, presence: true, length: { maximum: 30 }
  
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  
end