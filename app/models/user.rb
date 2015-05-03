class User < ActiveRecord::Base
  rolify

  devise :database_authenticatable, 
         :registerable, 
         :rememberable, 
         :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  
  before_save { email.downcase! }
  before_create :create_remember_token

  default_scope -> { order(name: :desc) }
  belongs_to :business
  has_many :created_cancellations, class_name: "Cancellation", foreign_key: :creator_id
  has_many :taken_cancellations, class_name: "Cancellation", foreign_key: :taker_id

  # validates :name, :email, presence: true
  validates :name, length: { in: 4..50 }
  validates :email, format: { with: MsUtilities::VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
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

