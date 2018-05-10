class User < ApplicationRecord
  
  validates :password_digest, :username, :session_token, presence: true 
  validates :password, length: { minimum: 6, allow_nil: true }
  attr_reader :password
  
  after_initialize :ensure_session_token
  
  has_many :cats,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Cat
  
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil 
  end 
  
  def ensure_session_token
    # debugger
    self.session_token ||= SecureRandom::urlsafe_base64
  end 
  
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end 
  
  def password=(password)
    @password = password 
    self.password_digest = BCrypt::Password.create(password)
  end 
  
  def is_password?(password)
    BCrypt::Password.create(password).is_password?(password)
  end 
  
  def find_by_credentials(user_name, password)
    user = User.find_by(username: user_name)
    return nil if user.nil?
    user.is_password?(password)? user : nil 
  end 
  
end
