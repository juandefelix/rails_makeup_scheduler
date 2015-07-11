class User < ActiveRecord::Base  
  rolify
  devise :registerable, :omniauthable, :recoverable, 
         :rememberable, :trackable,    :validatable, 
         :database_authenticatable, :omniauth_providers => [:facebook]
  belongs_to :business
  has_many :created_cancellations, class_name: "Cancellation", foreign_key: :creator_id
  has_many :taken_cancellations, class_name: "Cancellation", foreign_key: :taker_id

  default_scope -> { order(name: :desc) }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def exceeded_makeups?
    taken_cancellations.count >= created_cancellations.count
  end

  def from_omniauth?
    !uid.nil?
  end
end

