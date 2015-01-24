class User < ActiveRecord::Base
  rolify
  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, :email, :provider, presence: true
  validates :name, length: { in: 4..50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :uid, presence: true, uniqueness: { case_sensitive: false }
  # validates :password, length: { minimum: 6 }

  # has_secure_password

  has_many :created_cancellations, class_name: "Cancellation", foreign_key: :creator_id
  has_many :taken_cancellations, class_name: "Cancellation", foreign_key: :taker_id

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end

  def delete_taken_cancellations(cancellation)
    taken_cancellations.delete(cancellation)
    cancellation.taker = nil
    cancellation.save
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def exceeded_makeups?
    taken_cancellations.count >= created_cancellations.count
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end

